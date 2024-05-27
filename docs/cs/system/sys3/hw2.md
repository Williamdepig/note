# Linux 内核启动源码分析

## 跳板页表与内核页表

### `trampoline_pg_dir`

与我们在 `setup_vm` 中使用的 `early_tbl` 类似，`trapmpoline_pg_dir` 作为跳转页表，将 `OpenSBI` 的物理地址与虚拟地址建立 1GB 的一级映射关系。

```c
trampoline_pg_dir[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] = 
        pfn_pgd(PFN_DOWN(pa), prot);
// PAGE_OFFSET=0xffffffe000000000
// PGDIR_SHIFT=30
// PTRS_PER_PGD=512
```

### `swapper_pg_dir`

根据源码来看，在 `mm/init.c` 中，`swapper_pg_dir` 将物理地址的 128GB (当 `MAXPHYSMEM=128GB` 时)以及 `fixmap` 全部进行了映射。

```c
for (i = 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
// PGDIR_SIZE=0x40000000
    size_t o = (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;

    swapper_pg_dir[o] =
        pfn_pgd(PFN_DOWN(pa + i * PGDIR_SIZE), prot);
}

swapper_pg_dir[(FIXADDR_START >> PGDIR_SHIFT) % PTRS_PER_PGD] =
    pfn_pgd(PFN_DOWN((uintptr_t)fixmap_pte),
            __pgprot(_PAGE_TABLE));
```

### 设置 `satp`

如下，在 `relocate` 中，先设置了 `trapmpoline_pg_dir` 作为临时页表，当 `pc` 变成虚拟地址后，再重新设置 `swapper_pg_dir` 作为内核页表。

```asm
relocate:
    ...
    la a0, trampoline_pg_dir
    srl a0, a0, PAGE_SHIFT
    or a0, a0, a1
    sfence.vma
    csrw CSR_SATP, a0
.align 2
1:
    la a0, .Lsecondary_park
    csrw CSR_STVEC, a0

.option push
.option norelax
    la gp, __global_pointer$
.option pop

    csrw CSR_SATP, a2
    sfence.vma

    ret
```

## `pc`：从物理到虚拟

关键一步，就是 `relocate` 中对 `stvec` 的设置。首先需要手动计算标签 `1` 的虚拟地址，然后将其设置为 `stvec`。之后在设置了 `satp` 之后，下一条指令的 `pc` 依然是物理地址，但是 MMU 会依照虚拟地址做取值，导致异常，因而进入 `stvec` 指向的地址，即标签 `1`。此时就完成了 `pc` 从物理地址到虚拟地址的转换，然后 MMU 就能依照虚拟地址正常取出下一条指令给 CPU 执行。

```asm
relocate:
    /* Relocate return address */
    li a1, PAGE_OFFSET
    la a0, _start
    sub a1, a1, a0
    add ra, ra, a1

    /* Point stvec to virtual address of intruction after satp write */
    la a0, 1f
    add a0, a0, a1
    csrw CSR_STVEC, a0

    /* Compute satp for kernel page tables, but don't load it yet */
    la a2, swapper_pg_dir
    srl a2, a2, PAGE_SHIFT
    li a1, SATP_MODE
    or a2, a2, a1

    la a0, trampoline_pg_dir
    srl a0, a0, PAGE_SHIFT
    or a0, a0, a1
    sfence.vma
    csrw CSR_SATP, a0
.align 2
1:
    /* Set trap vector to spin forever to help debug */
    la a0, .Lsecondary_park
    csrw CSR_STVEC, a0
```

## 我的 kernel 设计

基本仿照如上设计，使用 `early_pgtbl` 作为临时页表，并将 `_after_satp` 作为 `stvec`。唯一的区别是由于符号表的初始设置，所取的标签地址就为虚拟地址，因而不需要手动计算 `stvec`，但计算 `satp` 需要额外做地址转换。

```asm
  la t0, _after_satp
  csrw stvec, t0

  # set satp with early_pgtbl‘s physical address

  la t0, early_pgtbl
  li t1, 0xffffffdf80000000
  sub t0, t0, t1
  li t1, 8
  slli t1, t1, 60     # mode 部分设置为 8
  srli t0, t0, 12     # PPN 部分设置为页表物理地址右移 12 位
  or t0, t0, t1
  csrw satp, t0

  # flush tlb
_after_satp:
  sfence.vma zero, zero
  fence.i

  ret
```
