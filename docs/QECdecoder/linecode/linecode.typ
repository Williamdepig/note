#import "@local/physics-note:0.1.0": *
#import "@preview/physica:0.9.8": *
#show: doc => conf(doc)
#set text(font: serif-fonts)
#show emph: set text(font: kai-fonts, weight: "medium")
#show strong: set text(font: sans-fonts)
#show smallcaps: set text(font: "Libertinus Serif")
#show link: set text(fill: rgb("#330fff"))

#let tensor = $times.o$
#let hm = $cal(H)$
#let cm = $cal(C)$
#let ec = smallcaps[EC]
#let meas = smallcaps[Meas]
#let hook = smallcaps[Hook]


= 一维线性架构上的常数编码率量子计算

本文分析 Gidney 和 Bergamaschi 的工作 _A Constant Rate Quantum Computer on a Line_#footnote[Craig Gidney and Thiago Bergamaschi, “A Constant Rate Quantum Computer on a Line”, arXiv:2502.16132, 2025.]。论文给出的不是一种新的静态一维局域稳定子码，而是一套由一维最近邻稳定子电路实现的容错协议。其最重要的结论是：只要允许校验测量在时间方向上具有足够深度，量子比特排成一条线也可以同时获得 *常数编码率* 与 *非零噪声阈值*。

#quote[
    空间局域性限制的是每一层电路“现在能碰到谁”，并不限制信息经过许多层以后“最终能传到谁”。本文用时间换取非局域校验，再用分层纠错阻止时间展开过程中的错误扩散。
]

全文可以压缩成以下逻辑链：

#align(center)[
    Hamming 码塔
    $arrow.r$
    双副本交织
    $arrow.r$
    无 hook 的递归测量
    $arrow.r$
    矩形阈值证明
    $arrow.r$
    magic state 注入
]


= 被绕开的限制究竟是什么

== 稳定子码与稳定子电路

Bravyi--Poulin--Terhal(BPT) 界讨论的是 *静态、几何局域的稳定子码*。对于二维局域的 $[[n,k,d]]$ 码，它给出
$
    k d^2 = O(n).
$
因此在二维同时保持常数编码率 $k/n$ 与增长的码距 $d$ 是不可能的；一维静态局域码受到的限制只会更强。

但是稳定子码只规定“一组相互对易的 Pauli 算子”，没有规定这些算子怎样被测量。它无法完整表达以下动态信息：

1. 校验是否分多轮、以何种顺序测量；
2. 测量辅助比特和 flag qubit 怎样参与电路；
3. 单个门故障会沿测量电路传播成什么 hook error；
4. 校验集合是否随时间变化，以及经典侧怎样记录 Pauli frame。

稳定子电路(stabilizer circuit)则由 Clifford 门、Pauli 测量、重置与经典反馈组成。它可以用许多层一维最近邻门去测量一个空间上非局域的 Pauli 乘积。因此 BPT 界不能直接从“局域码”推广为“局域电路”的界。

#rm(supplement: "没有违反 BPT 界")[
    论文的顶层 Hamming 校验在一维几何上并不局域，只是测量这些校验的 *每一个物理门* 都是最近邻的。非局域性被搬到了时间方向，所以该构造没有给出一个违反 BPT 界的一维局域稳定子码。
]

Baspin--Fawzi--Shayeghi 对局域稳定子电路给出的一个相关约束为
$
    k log delta^(-1) <= O(n Delta),
$
其中 $delta$ 是逻辑错误率，$Delta$ 是解码通道的深度。本文的症候提取与分层纠错电路很深，因而也不与该结论冲突。这里真正展示的是一个 *空间--时间权衡*：常数空间开销的代价是准多对数时间开销。


== 主要参数

#thm(
    [存在一族一维量子存储器 $cal(M)_n$，使用 $n$ 个物理比特编码超过 $n/20$ 个逻辑比特。其量子操作仅使用线上的最近邻门；在某个与 $n$ 无关的噪声阈值以下，每个电路周期的逻辑错误率满足
    $
        p_L = exp(-exp(Omega(log^(1/3) n))).
    $],
)

进一步加入 magic state 蒸馏后，任意由 $d$ 层一维最近邻双比特门组成、作用于 $m$ 个量子比特的电路，都可以用至多 $20m$ 个物理比特容错模拟。若目标误差为 $epsilon$，时间深度为
$
    d dot exp(O(log^3 log((m d)/epsilon))).
$
这里“常数率”只指空间开销 $n/k=O(1)$，并不意味着常数时间开销。


= 经过改造的量子 Hamming 码塔

== 量子 Hamming 码

#def(supplement: "量子 Hamming 码")[
    $m$ 阶量子 Hamming 码 $hm_m$ 是参数为
    $
        [[2^m-1, 2^m-2m-1, 3]]
    $
    的 CSS 码。其码距恒为 3，但编码率
    $
        R(hm_m) = (2^m-2m-1)/(2^m-1)
    $
    随 $m$ 增加趋近于 1。
]

一个 $X$ 型（或 $Z$ 型）校验是否作用在第 $i$ 个数据比特上，由整数 $i$ 的相应二进制位决定。因此单个 $Z$（或 $X$）错误翻转的校验集合，恰好给出错误位置的二进制表示。Hamming 码只能纠正一个未知位置的物理错误，但不断增大的码率使它适合构造常数率级联码。

如果反复级联同一个固定码，每一级都会乘上一个小于 1 的编码率，最终总编码率趋近于 0。Yamasaki--Koashi 的关键观察是逐级使用更高率的 Hamming 码：
$
    product_(i=4)^m R(hm_i)
$
收敛到一个非零常数。本文继承这一“码塔”，但为了实现一维最近邻操作又加入了三个改造。


== 两个基本操作

#def(supplement: "保留一个逻辑比特")[
    $"Reserve"_1(cm)$ 将码 $cm$ 的一个逻辑比特从用户数据中移出。它仍然被编码和保护，但专门用于保存测量所需的 cat state。
]

#def(supplement: "交织级联")[
    设外码 $A$ 和内码 $B$ 的参数分别为 $[[n_A,k_A,d_A]]$ 与 $[[n_B,k_B,d_B]]$。交织级联
    $
        A tensor B
    $
    使用 $k_B$ 份 $A$ 和 $n_A$ 份 $B$：每份外码的第 $i$ 个物理比特被送入第 $i$ 份内码。所得参数为
    $
        [[n_A n_B, k_A k_B, d_A d_B]].
    $
]

这和“把一个外码的每个物理比特各自编码一次”的标准叙述略有不同。交织的作用是让许多外码共享一组内码块，在不损失乘积编码率的前提下组织不同层级。

记 $2 tensor B$ 为两份并排放置的 $B$，但逻辑比特按奇偶交替编号：奇数逻辑比特属于第一份，偶数逻辑比特属于第二份。这个看似多余的双副本将在之后把相邻相关错误拆开。


== 递归定义与静态参数

论文使用的码族为
$
    cm_0 &= hm_4 tensor [[3,1,1]], \
    cm_(r+1) &= hm_(r+5) tensor (2 tensor "Reserve"_1(cm_r)).
$

$[[3,1,1]]$ 在这里不是为了增加码距，而是把每个底层数据比特扩展成三个相邻角色：

- data qubit：保存 Hamming 码的数据；
- measurement qubit：保存和读出 cat state；
- entangling qubit：帮助跨过 data qubit 建立相邻 cat parity。

每升一级，先保留一个 $cm_r$ 的逻辑比特作为 cat qubit，再把两份 $cm_r$ 并排且奇偶交织，最后作为内码承载外层 $hm_(r+5)$。

#thm(
    [$cm_r$ 的块长 $n_r$、编码率 $R_r$ 和静态码距 $d_r$ 满足
    $
        n_r &approx 42 dot 2^((r^2+11r)/2), \
        limits(lim)_(r arrow infinity) R_r &approx 6% > 1/20, \
        d_r &= 3^r = 2^(Theta(sqrt(log n_r))).
    $],
    proof: [
        Hamming 码块长为 $2^(r+5)-1$，双副本带来额外因子 2，因此
        $
            n_(r+1)=2(2^(r+5)-1)n_r.
        $
        对递推式取乘积即可得到 $n_r=2^(r^2/2+O(r))$。逻辑比特数满足
        $
            k_(r+1)=(2^(r+5)-2(r+5)-1) dot 2(k_r-1).
        $
        除以块长后，每一级只损失一个趋近于 1 的 Hamming 码率和一个保留逻辑比特；这些损失的无穷乘积收敛到约 $6%$。最后，保留操作和双副本交织不改变码距，每一级外层 Hamming 码将码距乘 3，故 $d_r=3^r$。
    ]
)

#rm(supplement: "静态码距不是完整答案")[
    $d_r=3^r$ 只描述抽象稳定子码可以承受多少数据 Pauli 错误。实际的一维测量电路可能把一个门故障传播成多个数据错误，所以还必须另外证明 *电路 fault distance*。论文的主要技术工作正是在证明测量器件不会产生危险的相关错误。
]


= 一维最近邻的递归测量

== 为什么直接 SWAP 会失败

距离为 3 的码只能纠正一个未知错误。在一维线上，如果为了让两个远处数据比特相遇而在同一码块内部执行 SWAP，一个坏掉的双比特门可能同时破坏两个相邻数据比特，直接耗尽码的纠错能力。

本文没有试图让所有逻辑比特彼此移动来完成每个高权校验，而是反过来：在保留逻辑比特上制备一条 cat state，让它作为分布式探针同时接触校验支撑集上的数据。


== Shor 型 Pauli 乘积测量

设待测算子为
$
    M=P_(q_1) tensor P_(q_2) tensor dots tensor P_(q_t).
$
Shor 测量器件先制备
$
    ket("cat")=(ket(0)^tensor t+ket(1)^tensor t)/sqrt(2),
$
再将第 $i$ 个 cat qubit 与第 $i$ 个数据比特配对，测量 $P_(q_i) tensor X_(c_i)$，最后在 $Z$ 基测量 cat qubits。所有局部结果的奇偶校验给出 $M$ 的测量值。

普通的顺序 CNOT 链会有严重 hook error：cat state 制备早期的一个故障可以沿链扩散成一长段 $X$ 错误，再反向传播到许多数据比特。本文使用三轮最近邻 $Z_i Z_(i+1)$ 测量，把 cat qubits 当作一个 repetition code 来制备和硬化。一个局域故障至多留下相邻的 cat errors，而不会长成任意长度的错误串。


== 三种递归器件

对每个层级 $r$，论文区分三种功能不同的器件：

#table(
    columns: (1.1fr, 1.8fr, 2.6fr),
    align: (center, left, left),
    inset: 0.65em,
    stroke: 0.5pt + luma(180),
    table.header([*器件*], [*结构*], [*保证*]),
    [$r$-#hook],
    [递归实现一次 Shor 型测量],
    [测量结果可以错，但不能制造非局域的数据损伤；即“结果不可靠、传播受控制”],
    [$r$-#ec],
    [对该层所有外层 Hamming 稳定子各做三轮 $r$-#hook],
    [用三轮症候的时间冗余定位一次输入错误或一次器件故障],
    [$r$-#meas],
    [三次测量目标逻辑 Pauli 乘积，并在相邻两次之间插入 $r$-#ec],
    [供用户或上一级调用的容错测量；多数表决恢复测量值，#ec 阻止同一数据错误同时污染多轮结果],
)

它们的关系不是三个平行模块，而是一个递归闭环：
$
    r "-Hook"
    arrow.r
    (r-1) "-Meas" + (r-1) "-EC"
    arrow.r
    r "-EC", r "-Meas".
$

在 $r$-#hook 中，cat state 保存于每个 $cm_(r-1)$ 块预留的逻辑比特上。相邻预留比特之间的 $Z Z$ 测量由 $(r-1)$-#meas 完成，并与 $(r-1)$-#ec 交替；cat state 制备完成后，再在每个子块内部测量 cat qubit 与 Hamming 数据逻辑比特的 Pauli parity。


== 底层最近邻实现

$0$-#hook 是递归的基例。measurement qubit 与 entangling qubit 可以直接相邻，但某些 CNOT 必须跨过中间的 data qubit。论文把一个次近邻 CNOT 分解为四个最近邻 CNOT，因此电路中确实存在“同时碰到 cat 和 data”的故障位置。

对所有单个双比特故障做传播分析后，可以证明：

#lemma(
    [若两个相邻 $cm_0$ 块的输入没有错误，$0$-#hook 中至多发生一个双比特门故障，则每个输出块至多包含一对相邻物理错误。测量值本身可以任意。],
)

直觉上，$Z$ 错误沿 CNOT 传播时至多翻转 cat 的最终读出，$X$ 错误至多翻转相邻 $Z Z$ parity；三轮 repetition measurement 使错误位置可被识别。更重要的是，传播到 data qubit 的错误数至多为一个。这个逐位置分析为后续所有层级的归纳提供基例。


= 双副本交织如何吸收相邻故障

一维门天然可能同时损坏两个相邻子块，所以证明不能把“任意两个错误”都当作可纠正。论文只追踪一种由几何局域性强制出来的特殊形状。

#def(supplement: [$r$-error 与 $r$-adj-error])[
    $0$-error 是一个物理 Pauli 错误。对于 $r>=1$，若一个 $cm_(r-1)$ 子块中包含至少两个 *不相邻* 的 $(r-1)$-error，则把整个子块记为一个 $r$-error。若两个 $r$-error 位于相邻的 $cm_(r-1)$ 子块中，则称其为一个 $r$-adj-error。
]

这里故意允许“一对相邻 $r$-error”。原因是双副本的奇偶交织：两个相邻 $cm_(r-1)$ 块属于不同的外层 Hamming 码副本。因此从每个 Hamming 码单独看，它只收到一个物理位置错误，仍在距离 3 Hamming 码的纠错能力内。

#lemma(
    [若一个 $cm_r$ 块至多包含一个 $r$-adj-error，则存在无噪声递归解码器将它恢复。],
    proof: [
        先分别解码所有 $cm_(r-1)$ 子块。除相邻的两个坏子块外，其余子块的低层错误均被消除。再看外层 Hamming 码：由于奇偶交织，这两个相邻坏块映射到不同的 Hamming 码副本，每份外码各自只含一个错误，可以被距离 3 的 Hamming 解码器纠正。逐层归纳即可。
    ]
)

所以双副本不是为了把码距从 3 提升到 6，而是把“一次一维局域操作造成的相关双块故障”重新解释为“两份外码各自的一次单块故障”。这是整套构造能够放到一维线上的关键。


= Threshold Dance：从错误形状到阈值

== Rectangle

#def(supplement: [$r$-Rec])[
    一个 $r$-rectangle（简写为 $r$-Rec）由一次 $r$-#meas 及其前后至多四个相邻的 $r$-#ec 组成。若输入的每个 $r$-block 至多有一个 $r$-adj-error，输出仍满足同一条件，则称该 rectangle 正确(correct)。
]

按照 concatenated simulation 的标准做法，递归定义 good/bad rectangle：

- $0$-Rec 至少包含两个物理故障时为 bad；
- $r$-Rec 至少包含两个彼此独立的 bad $(r-1)$-Rec 时为 bad；
- 相邻 rectangle 共享 #ec 时，必须去除共享部分后仍然为 bad，才视为彼此独立。

共享 #ec 的处理避免同一个底层故障在两个相邻 rectangle 中被重复计数。


== 四个错误传播性质

论文没有直接枚举任意长电路中的所有错误，而是证明 #ec 与 #meas 满足四个局部接口条件：

#table(
    columns: (1.25fr, 2.15fr, 2.15fr),
    align: (center, left, left),
    inset: 0.65em,
    stroke: 0.5pt + luma(180),
    table.header([], [*无内部坏块，但输入有一个 $r$-adj-error*], [*输入无 $r$-error，但执行中有一个坏块*]),
    [*$r$-#ec*],
    [消除输入的 $r$-error],
    [输出至多产生一个 $r$-adj-error],
    [*$r$-#meas*],
    [测量正确，输出至多保留一个 $r$-adj-error],
    [测量由三轮多数表决恢复，输出至多产生一个 $r$-adj-error],
)

归纳还需要一个看似更强的性质：即使 $r$-#ec 的输入是任意量子态，只要内部至多有一个允许的坏块，它也能把输出投影回 $cm_r$ 的编码空间，至多留下一个 $r$-adj-error；编码的逻辑态可以是任意的。

三轮重复在这里承担两个不同角色：

1. 若故障发生在第一轮，后两轮一致，可以采用后两轮；
2. 若故障发生在第三轮，前两轮一致，可以采用前两轮；
3. 若故障发生在中间轮，则根据第一、二轮是否一致，决定采用前两轮或无故障的第三轮。

这就是标题中的 “threshold dance”：错误在 #hook、#ec、#meas 之间移动，但每一步都把它限制为至多一个相邻错误对。


== Good 推出 Correct

#thm(
    [若所有层级的 #ec 与 #meas 均满足上述错误传播性质，并且电路中的所有 $r$-Rec 都是 good，则所有 $r$-Rec 都是 correct，最终逻辑信息可以被无噪声解码器恢复。],
    proof: [
        bad $(r-1)$-Rec 只能落在 rectangle 的前置 #ec、#meas 或后置 #ec 三处之一。若在前置 #ec，先用“错误执行”性质把它限制为一个 $r$-adj-error，再由无故障的后续器件消除；若在 #meas，同理先由前置 #ec 清空输入错误，再限制测量器件产生的错误；若在后置 #ec，输出可能保留一个相邻错误对，但下一个 rectangle 的前置 #ec 与它共享，独立性定义保证下一处不再同时出现新的坏块。因而错误不会跨 rectangle 增殖。
    ]
)


== 坏矩形的双指数抑制

记 $p_r$ 为给定 $r$-Rec 是 bad 的概率，$V_r$ 为其中包含的 $(r-1)$-Rec 数量。一个 $r$-Rec 要 bad，至少需要两个独立的低层 bad rectangle，因此由 union bound 有
$
    p_r <= O(V_r^2 p_(r-1)^2).
$

虽然 $V_r=2^("poly"(r))$ 随层级增长，但递推中的平方不断把指数翻倍。取足够低的物理噪声率 $p<p^*$，可以归纳得到某个 $0<c<1$ 使
$
    p_r <= 2^(-2^(c r)).
$
也就是说，坏 rectangle 的概率随级联层数双指数下降。$V_r$ 的增长只贡献 $r$ 的多项式项，最终会被 $2^(c r)$ 压倒。

论文再把总计 $n$ 个物理比特分成许多相邻的 $cm_r$ 块，并行维护，而不是让整台机器只使用一个巨大码块。选择
$
    r=Theta(log^(1/3) n)
$
后，对所有块做 union bound，仍有
$
    p_L <= n dot 2^(-2^(Theta(r)))
        = exp(-exp(Omega(log^(1/3)n))).
$
同时每个块的大小 $2^(Theta(r^2))=exp(Theta(log^(2/3)n))$ 远小于 $n$，舍弃末尾装不满一个块的比特不会破坏 $1/20$ 的总编码率。


= 时间开销从哪里来

设 $T_r$ 为完成一次 $r$-#meas 的物理电路深度。外层 Hamming 稳定子支撑集高度重叠，论文保守地将它们顺序测量；每次外层测量之间还要执行低一层纠错。因此
$
    T_r=O(n_r T_(r-1))=2^(O(r^3)).
$

如果整台机器只用一个块，因 $n_r=2^(Theta(r^2))$，上述深度甚至是块长的超多项式。将存储器切成许多较小块，正是在逻辑错误率、块长和周期深度之间重新选择平衡。

#rm(supplement: "常数率不等于高性能")[
    该结果是渐近存在性构造。论文没有给出实用的数值阈值，底层最近邻电路和递归三重测量具有很大的常数，外层稳定子又被顺序执行。它证明“一维常数空间开销并非原理上不可能”，并不意味着该方案在近期硬件上优于表面码。
]


= 从量子存储器到通用量子计算机

== Clifford 运算

$r$-#meas 可以测量一个或两个相邻 $cm_r$ 块上的任意逻辑 Pauli 乘积。配合逻辑 Pauli eigenstate 初始化、测量和经典 feed-forward，任意 Clifford 电路都可以转写成 Pauli product measurements。因此存储器本身已经支持完整的稳定子计算。

通用计算还缺少一个 non-Clifford 资源，论文选择逻辑 $T ket(+)$ magic state。


== 不同层级之间的 magic state 梯子

普通递归器件只允许同一层级的相邻码块交互。为了把物理层制备的 noisy $T ket(+)$ 送入顶层 $cm_r$，论文在相邻数据块之间放置
$
    cm_0, cm_1, dots, cm_(r-1)
$
组成的“梯子”。一次从 $cm_i$ 到 $cm_(i+1)$ 的传送包含：

1. 在 $cm_i$ 的一个逻辑比特与 $cm_(i+1)$ 内各子块的保留比特之间制备 multipartite cat state；
2. 通过跨层逻辑 $X X$ 测量建立一个 $cm_i$--$cm_(i+1)$ EPR pair；
3. 使用 Bell/Pauli 测量和 feed-forward，把 $T ket(+)$ teleport 到 $cm_(i+1)$。

沿梯子逐级重复后，顶层得到保真度 $1-Theta(p)$ 的逻辑 magic state。重要的是这里并不要求单个注入态已经具有随 $r$ 增长的高保真度；只要物理噪声低于一个常数，使输出超过 magic state distillation threshold 即可。


== 蒸馏、搬运与注入

在顶层 $cm_r$ 内注入 $"polylog"(1/delta)$ 个 noisy magic states，再用 stabilizer circuit 蒸馏出误差 $delta$ 的 $T ket(+)$。数据块与蒸馏块之间隔着梯子，因此还需要搬运：论文只让 data qubit 与旁边初始化为 $ket(0)$ 的 helper qubit 做 SWAP，并在各层 SWAP 之间插入纠错轮次。最后通过受控 Pauli 测量和 Clifford 修正完成 $T$ gate injection。

一层逻辑 $T$ 门和最近邻双比特门的时间开销为
$
    exp(Theta(r^3)) dot "polylog"(1/delta).
$
选择 $r=Theta(log log(1/delta))$ 后得到准多对数开销
$
    exp(Theta(log^3 log(1/delta))).
$
梯子与蒸馏区所占空间相对顶层数据块渐近为 $o(1)$，所以总编码率仍可保持在 $1/20$ 以上。


= 假设、边界与应如何理解结果

== 噪声与经典控制

论文使用 local stochastic noise：对任意物理比特集合 $S$，一次噪声层同时损坏 $S$ 的概率满足
$
    P[S subset.eq "supp"(E)] <= p^(|S|),
$
集合内部的误差通道可以是对抗性的和相关的。正文的具体参数定理也以均匀 depolarizing circuit noise 表述。

经典控制被假设为无噪声且可以长程通信。对于单纯量子存储，不需要实时反馈：症候与 Pauli correction 可以一直保存在经典 Pauli frame 中，最后统一后处理。对于 magic state teleportation、蒸馏和通用计算，则假设准多对数时间的经典计算和 feed-forward 可以视为即时。


== 结论没有包含什么

1. *没有实用阈值数值。* 证明只说明存在某个与系统规模无关的 $p^*>0$。
2. *没有消除时间代价。* 常数空间开销来自很深的递归症候提取；外层校验的顺序执行尤其昂贵。
3. *没有构造静态一维局域好码。* 高权 Hamming 校验仍然非局域，只是由一维最近邻电路在时间中完成。
4. *目标精度不能对固定规模任意降低而仍保持定理参数。* 为保持块长和辅助区为 $o(m)$，计算定理要求
   $
        d/epsilon <= exp(exp(O(log^(1/3)m))).
   $
5. *量子部分局域，经典部分并不局域。* 因而它回答的是带理想经典控制器的量子硬件空间布局问题。


= 核心认识

这篇论文最值得保留的不是某一个递推参数，而是一种设计容错协议的方式：

1. 先识别硬件局域门实际会制造的 *错误形状*，这里是相邻块成对损坏；
2. 再改变编码布局，使这种错误形状在外码看来仍是低权错误，双副本交织正为此服务；
3. 将“测量结果可靠”和“数据不被破坏”分开设计，先构造允许读数错误的 #hook，再用时间冗余组成 #ec 与 #meas；
4. 最后只对这些器件证明封闭的错误传播接口，通过 rectangle percolation 得到全局阈值。

#quote[
    BPT 界告诉我们静态局域稳定子码不能做什么；本文则说明，一旦允许代码由深的时空电路来实现，真正受限的对象不再只是空间中的码，而是整个 syndrome extraction、纠错与经典控制共同构成的时空协议。
]
