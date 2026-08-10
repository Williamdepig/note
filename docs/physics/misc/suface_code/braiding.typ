#import "template.typ": *
#import "@preview/physica:0.9.8": *
#show: doc => conf(doc)
#set text(
    font: serif-fonts
)
#show emph: set text(font: kai-fonts, weight: "medium")
#show strong: set text(font: sans-fonts)
#show smallcaps: set text(font: "Libertinus Serif")
#show link: set text(fill: rgb("#330fff"))

#let cs = $cal(S)$
#let cc = $cal(C)$
#let tensor = $times.o$

= Logical Operations in Defect-based Surface Code
== Braiding #footnote[Fowler, Austin G., Ashley M. Stephens, and Peter Groszkowski. “High Threshold Universal Quantum Computation on the Surface Code”. _Physical Review A_ 80, no. 5 (November 2009): 052312. https://doi.org/10.1103/PhysRevA.80.052312.]
Braiding 的想法是：先通过局部测量扩大一个缺陷(defect)，让扩大的部分绕过另一个缺陷，再从尾部逐步恢复稳定子测量，使前一个缺陷回到原位。物理上改变的始终只是局部测量集合；但在整个过程中，逻辑算子的链会被拖动或者变形，因此一个闭合的绕行可以产生非平凡的逻辑门。

需要强调的是，这里的 braid 并不是交换两个物理粒子的位置。每个缺陷在操作结束后都回到原位，真正重要的是缺陷在二维空间与时间组成的 $2+1$ 维时空中形成的世界管(world tube)是否相互链接。

=== Defect Qubits
在完整的表面码中，每个独立稳定子都给出一个约束。停止测量某个稳定子，或者测量掉一片数据比特并相应地修改边界稳定子，就会移除一个独立约束，从而引入一个新的逻辑自由度。被挖去的区域称为一个 *缺陷(defect)* 或者洞(hole)。

单个缺陷也能与外边界共同编码一个逻辑比特，但此时一个逻辑算子必须一直连接到外边界，不方便移动和排布。通常使用两个同类型缺陷编码一个逻辑比特，两个缺陷共同承载一个逻辑自由度。

#def(supplement: "双缺陷逻辑比特")[
    采用 Fowler 等人的命名约定：
    - *Smooth defect* 由 $X$ basis 测量形成，内部的 $Z$ 型校验停止测量。其逻辑 $X_L$ 是连接两个 smooth defects 的 $X$ 链，逻辑 $Z_L$ 是环绕任意一个缺陷的 $Z$ 环。
    - *Rough defect* 由 $Z$ basis 测量形成，内部的 $X$ 型校验停止测量。其逻辑 $Z_L$ 是连接两个 rough defects 的 $Z$ 链，逻辑 $X_L$ 是环绕任意一个缺陷的 $X$ 环。
]

#figure(
    table(
        columns: (auto, 1fr, 1fr, auto),
        inset: 6pt,
        align: (left, left, left, center),
        [*缺陷类型*], [*$X_L$*], [*$Z_L$*], [*自然初始化*],
        [Smooth], [$X$ 链连接两个缺陷], [$Z$ 环绕一个缺陷], [$ket(0)_L$],
        [Rough], [$X$ 环绕一个缺陷], [$Z$ 链连接两个缺陷], [$ket(+)_L$],
    ),
    caption: [Logical operators of double-defect qubits]
)<double-defect-operators>

以 smooth qubit 为例，环绕左缺陷和环绕右缺陷的两个 $Z$ 环看似不同，但二者的乘积可以由中间区域的 $Z$ 型稳定子生成，因此它们只相差一个稳定子，在编码空间上表示同一个 $Z_L$。同理，连接两个缺陷的 $X$ 链也可以乘以 $X$ 型稳定子而连续变形，而不改变其逻辑作用。

也就是说，我们真正关心的不是某一条确定的物理链，而是模去稳定子后的等价类
$ macron(P) equiv macron(P) S, quad S in cs. $
Braiding 正是通过改变稳定子集合，使这些逻辑算子的等价类发生非平凡变换。

=== Defect Movement
缺陷移动(defect movement)可以分解为“在前方扩张、在后方收缩”两个过程。仍以 smooth defect 为例：

1. 在移动方向上选取一片数据比特，在 $X$ basis 上测量它们，停止所有与这些测量反对易的 $Z$ 型稳定子，并将相邻的 $X$ 型稳定子改写为新的边界稳定子。缺陷因此向前扩张。
2. 根据单比特测量结果更新新边界稳定子的符号。负号不必立即用物理 $Z$ 门消除，可以交给解码器并记入 Pauli frame。
3. 进行若干轮 syndrome extraction，使扩张时产生的测量错误能够在时空中被匹配和纠正。
4. 在旧边界处重新测量先前关闭的 $Z$ 型稳定子，必要时记录一个 $X$ 修正，旧区域被重新纳入表面码，缺陷从尾部收缩。

Rough defect 的移动过程完全对偶，只需交换 $X$ 与 $Z$。

#def(supplement: "逻辑算子的拖动规则")[
    移动 smooth defect 时，环绕缺陷的 $Z_L$ 随边界连续变形；所有以该缺陷为端点的 $X_L$ 都必须跟随缺陷一起延长或缩短。移动 rough defect 时交换 $X$ 与 $Z$：$X_L$ 环连续变形，而以缺陷为端点的 $Z_L$ 被拖动。
]

如果移动路径附近没有其他缺陷，上述变形只相当于给逻辑算子乘上若干稳定子，因此逻辑态不变。一旦路径绕过异型缺陷，拖动后的链就可能多出一个不能由稳定子消除的逻辑环，这才产生逻辑门。

=== Mixed-type Braid is CNOT
考虑一个 smooth qubit $c$ 和一个 rough qubit $t$。将构成 $c$ 的任意一个 smooth defect 绕构成 $t$ 的任意一个 rough defect 一周，再让它回到原位。记这一闭合操作为 $B_(c,t)$。

#thm(
    [在上述约定下，$B_(c,t)$ 等价于以 smooth qubit $c$ 为 control、rough qubit $t$ 为 target 的逻辑 $"CNOT"_(c arrow.r t)$。],
    proof: [
        只需跟踪两比特 Pauli 群的四个逻辑生成元。

        首先考虑 $X_c$。它是一条连接两个 smooth defects 的 $X$ 链。当其中一个端点绕过 rough defect 时，这条链被一起拖动；操作结束后，它比原来的链多环绕 rough defect 一周。这个额外的 $X$ 环正是 $X_t$，因此
        $ X_c tensor I_t arrow.r X_c tensor X_t. $

        再考虑 $Z_t$。它是一条连接两个 rough defects 的 $Z$ 链。为了避开正在绕行的 smooth defect，该链在变形后会多出一个环绕 smooth defect 的 $Z$ 环，也就是 $Z_c$，因此
        $ I_c tensor Z_t arrow.r Z_c tensor Z_t. $

        另一方面，$Z_c$ 本身就是环绕 smooth defect 的 $Z$ 环，完成闭合路径后仍与原来的环同伦；$X_t$ 也是环绕 rough defect 的 $X$ 环，不会被这次运动拖走。因此
        $ Z_c tensor I_t &arrow.r Z_c tensor I_t, \
          I_c tensor X_t &arrow.r I_c tensor X_t. $

        综上，$B_(c,t)$ 对逻辑 Pauli 生成元的共轭作用为
        $ B_(c,t) (X_c tensor I_t) B_(c,t)^dagger &= X_c tensor X_t, \
          B_(c,t) (I_c tensor X_t) B_(c,t)^dagger &= I_c tensor X_t, \
          B_(c,t) (Z_c tensor I_t) B_(c,t)^dagger &= Z_c tensor I_t, \
          B_(c,t) (I_c tensor Z_t) B_(c,t)^dagger &= Z_c tensor Z_t. $
        这恰好是 $"CNOT"_(c arrow.r t)$ 的 Heisenberg 作用，所以二者至多相差一个全局相位，即实现同一个逻辑门。
    ]
)<braid-cnot>

#figure(
    table(
        columns: (1fr, auto, 1fr),
        inset: 6pt,
        align: center,
        [*Braid 前*], [], [*Braid 后*],
        [$X_c$], [$arrow.r$], [$X_c X_t$],
        [$X_t$], [$arrow.r$], [$X_t$],
        [$Z_c$], [$arrow.r$], [$Z_c$],
        [$Z_t$], [$arrow.r$], [$Z_c Z_t$],
    ),
    caption: [Logical Pauli propagation of the mixed-type braid]
)<braid-pauli-map>

这个结果有几个容易混淆的地方：
- smooth qubit 固定为 control，rough qubit 固定为 target；如果交换二者的逻辑角色，需要额外的 Hadamard 或 teleportation 电路。
- 移动哪一个 smooth defect、绕过哪一个 rough defect都不重要，因为同一逻辑比特中的两个环表示等价的逻辑算子。
- 顺时针和逆时针也给出相同的门。表面码中的逻辑 Pauli 链只记录模 $2$ 的绕数，一个正向或反向的单次绕行都有奇数 linking number。
- 两个同类型缺陷之间的普通绕行不会产生上述交叉的 $X/Z$ 传播；非平凡 CNOT 来自 smooth 与 rough 两类缺陷的互绕。

=== CNOT between Qubits of the Same Type
Mixed-type braid 只能直接实现 smooth $arrow.r$ rough 的 CNOT，但实际计算中通常希望所有数据比特采用同一种编码。可以通过两个 ancilla qubits 和逻辑测量，把 mixed-type CNOT 转换为同类型 CNOT。

以 smooth control $C$ 和 smooth target $T$ 为例：

1. 准备一个 rough ancilla $R$ 于 $ket(0)_L$，再准备一个 smooth ancilla $A$ 于 $ket(+)_L$。
2. 通过三次 mixed-type braids 依次实现 $"CNOT"_(T arrow.r R)$、$"CNOT"_(C arrow.r R)$ 和 $"CNOT"_(A arrow.r R)$。三者共享 rough target $R$。
3. 在 $Z_L$ basis 测量 $R$，结果记为 $m_Z$；在 $X_L$ basis 测量原 target $T$，结果记为 $m_X$。约定测得本征值 $(-1)^m$。
4. 原 control $C$ 保留，smooth ancilla $A$ 成为新的 target。二者的逻辑态等于先对 $C,T$ 施加 CNOT，再附带 Pauli byproduct
   $ F = (Z_C Z_A)^(m_X) X_A^(m_Z). $
   不需要真的施加 $F$，在 Pauli frame 中记录即可。

因此 same-type CNOT 的信息并不是沿二维平面直接穿过其他逻辑比特，而是经由一个异型 ancilla 的 world tube 完成 teleportation。将时间作为第三个方向后，一整个逻辑 Clifford 电路就可以画成若干相互链接的管道；连续变形管道而不改变链接关系，不会改变对应的逻辑运算。

=== Fault Tolerance
Braiding 的拓扑不变性并不意味着可以随意压缩缺陷。操作过程中的有效码距应定义为当时所有非平凡逻辑链与逻辑环的最小权：
$ d(t) = min_(P in cc(cs(t)) - cs(t)) |P|. $
为了实现目标码距 $d$，必须在每个时刻保持 $d(t) >= d$。具体来说：

- 每个缺陷的周长必须足够大，否则一个很短的 Pauli 环就能围住缺陷并形成逻辑错误。
- 同一逻辑比特的两个缺陷之间、缺陷与同类型边界之间，以及 braid 路径与其他相关缺陷之间都必须保持足够距离，否则会出现很短的连接链。
- 打开或恢复稳定子之后必须重复 syndrome extraction。单轮测量无法区分数据错误和测量错误，解码器需要在时空 syndrome graph 上完成匹配。对于距离 $d$ 的容错操作，通常需要保留 $O(d)$ 的时间方向保护。#footnote[Horsman, Clare, Austin G. Fowler, Simon Devitt, and Rodney Van Meter. “Surface Code Quantum Computing by Lattice Surgery”. _New Journal of Physics_ 14 (2012): 123011. https://doi.org/10.1088/1367-2630/14/12/123011.]
- 扩张缺陷时产生的随机边界稳定子符号，以及收缩时新测得的稳定子符号，都必须由 decoder 解释并更新 Pauli frame。

Fowler 等人在 2009 年的分析中进一步指出，若将长距离扩张并行完成，并以“初始测量产生的边界错误仍未被清除”的概率作为停止条件，则所需纠错轮数只随边界长度的对数增长，因此远距离 braid 不需要远距离物理耦合。这个结论描述的是特定纠错调度的延迟；实际实现仍需根据噪声模型与 decoder 检查整个时空过程的最小距离，不能把几何上的一次延长视作无误差的瞬时操作。

还有一个看似方便但实际错误的操作：不能一次在包围 rough defect 的完整闭合环上做 $X$ basis 测量来“瞬间”完成 smooth braid。这个测量环本身就是 rough qubit 的 $X_L$，会直接测量并坍缩 target 的逻辑态。正确做法是让缺陷保持一个开口，从一端逐步延长并在另一端恢复稳定子，使逻辑信息始终留在编码空间中。

#def(supplement: "Braiding 的本质")[
    Braiding 是一种具有非平凡时空拓扑的 code deformation。局部操作负责移动缺陷；逻辑门由逻辑 Pauli 链在移动过程中的同伦类变化决定；容错性则来自整个过程中非平凡链始终具有至少 $d$ 的权，而不是来自路径在几何上看起来平滑。
]

Braiding 直接给出一个受拓扑保护的 Clifford entangling gate，但它本身并不构成通用门集。还需要逻辑 Hadamard、相位门以及通过 state injection 和 magic-state distillation 实现的 non-Clifford 门。与 planar patches 上的 lattice surgery 相比，braiding 保留了二维最近邻局部操作的优势，但 double-defect encoding 与缺陷间距会占用较大的空间，因此现代架构经常根据布局和资源开销在两种方案之间选择。#footnote[Fowler, Austin G., Matteo Mariantoni, John M. Martinis, and Andrew N. Cleland. “Surface Codes: Towards Practical Large-Scale Quantum Computation”. _Physical Review A_ 86, no. 3 (September 2012): 032324. https://doi.org/10.1103/PhysRevA.86.032324.]
