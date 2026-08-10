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
#let cp = $cal(P)$
#let cc = $cal(C)$
#let cs = $cal(S)$
#let ct = $cal(T)$
#let pm = $plus.minus$
#let ii = $upright(i)$
#let tensor = $times.o$


= 表面码数学原理
== 稳定子码
=== 泡利群、稳定子群、编码空间
泡利群(Pauli group) $cp_n$ 为泡利算子 $chevron.l X, Y, Z chevron.r$ 的 $n$ 次张量积：$ cp_n = {pm 1, pm ii} dot {pm upright(I), pm ii I, pm X, pm Y, pm Z}^(tensor n). $
其满足：1. $cp_n$ 中的任意两个元素是对易(commute)或反对易的(anticommute)；2. $cp_n$ 中的任意元素是厄米(Hermitian)或反厄米的(anti-Hermitian)；3. $cp_n$ 中的任意元素是幺正的(unitary)。

稳定子群(stabilizer group) $cs$ 是泡利群的一个阿贝尔子群(abelian subgroup)，即 $cs$ 中的任意两个元素是对易的。注意我们定义 $-I in.not cs$。

#def(supplement:"编码空间")[
    编码空间(codespace) $ct(cs)$ 是 $cs$ 中特征值为 $+1$ 的特征向量构成的空间：$ ct(cs) = {ket(psi) | S ket(psi) = ket(psi), forall S in cs}. $
]

=== 中心化子、正规化子
中心化子(centralizer) $cc(cs)$ 是泡利群中与 $cs$ 中的所有元素对易的元素构成的子群：$ cc(cs) = {E in cp_n | [E, S] = 0, forall S in cs}. $
正规化子(normalizer) $cal(N)(cs)$ 是泡利群中与 $cs$ 中的所有元素通过共轭保持不变的元素构成的子群：$ cal(N)(cs) = {E in cp_n | E^dagger S E in cs, forall S in cs}. $
#thm(
    [在泡利群中，$cc(cs)=cal(N)(cs)$。],
    proof: [
        泡利群中任意两个元素是对易或反对易的，则有
        $ E^dagger S E = pm E^dagger E S = pm S, $
        又 $-I in.not cs$，即 $-S in.not cs$，有 
        $ E^dagger S E &= S \ arrow.double S E &= E S. $
        因此 $cc(cs)=cal(N)(cs)$ 得证。
    ]
)

对于任意 $E in cc(cs)-S$，其为一个无法检测的逻辑错误(logical error)，即 $E$ 作用在编码空间 $ct(cs)$ 上的结果仍然在编码空间中，但是又会改变当前的态。因此可称之为一个逻辑算子(logical operator)，能进行逻辑 $chevron.l X, Y, Z chevron.r$ 操作。
#def(supplement: "码距")[
    泡利算子 $P in cp_n$ 的权 $|P|$ 是它产生非平凡作用（即并非 $I$ 算子）的量子比特的个数。该稳定子码的码距(code distance)定义为 $cc(cs)-cs$ 中元素的最小权的大小。
]<code-distance>

=== 生成元与错误症候
稳定子群 $cs$ 的生成元 ${S_1, S_2, ..., S_r}$ 被称为校验算子(check operators)。
#def(supplement: "错误症候")[
    给定一个泡利错误 $E in cp_n$，其症候(syndrome) $sigma(E)$ 定义如下：
    $ 
    sigma_(S)(E) &= cases(
        0 space "if" [S,E] = 0 &("commute"),
        1 space "if" {S,E} = 0 space&("anticommute"),
    ) \
    sigma(E) &= (
        sigma_(S_1)(E), sigma_(S_2)(E), ..., sigma_(S_r)(E)
    )
    $
]<syndrome>
=== 纠错理论
给定一个错误症候 $sigma(E)$，解码器根据它来选择一个纠错算子 $R in cp_n$，若 $R E in cs$，就有 $R E ket(psi) = ket(psi)$，纠错成功；若 $R E in cp_n - cc(cs)$，就有 $R E ket(psi)$ 不处于 $ct(cs)$ 编码空间中，不是一个正确编码，纠错失败。
#thm(
    [当 $R$ 和 $E$ 的症候相同时，$R E in cc(cs)$。],
    proof: [
        对于任意一个稳定子 $S in cs$，有 
        $  
        R E S &= R (E S) = (-1)^(sigma_S (E)) R S E \
        S R E &= (S R) E = (-1)^(sigma_S (R)) R S E.
        $
        由于症候相同，即 $sigma_S (E) = sigma_S (R)$，因此 
        $ 
        (R E) S &= S (R E), forall S in cs \
        arrow.double R E &in cc(cs)
        $
        得证。

        此时若 $R E in cc(cs) - cs$，则发生一个逻辑错误(logical error)，逻辑比特的逻辑态被改变。
    ]
)


==  Planar-based Surface Code
#rm[
你可能见过以下几种表面码的图示：
#figure(
    grid(
        columns: 3,
        gutter: 1em,
        align: horizon,
        grid.cell[#image("img/img1.png", width: 80%) (a)],
        grid.cell[#image("img/img2.png", width: 80%) (b)],
        grid.cell[#image("img/img3.png", width: 80%) (c)]
    ),
    caption: "Different surface code representations",
) <surface-code-represent>
实际上三者是一致的，只是进行了一些旋转以及边和顶点的交换，我们会在之后展示。这里使用#ref(<surface-code-represent>)中的图(a)来介绍表面码的基本概念。
]
=== 表面码的构成
在图(a)当中，我们将 *数据比特放置在每条边* 上；在每个顶点处放置 $Z$ 型稳定子，称之为 *顶点稳定子(vertex stabilizers)*；在每个面心处放置 $X$ 型稳定子，称之为 *面稳定子(plaquette stabilizers)*。在后面的检错与纠错阶段，我们将看到这样定义的方便之处。

下图是两种稳定子的示意，红色意味着 $X$ 型稳定子，其作用在该面的四条边上；蓝色则为 $Z$ 型稳定子，作用在顶点相连的四条边上。
#figure(
    image("img/img4.png", width: 60%),
    caption: "Examples of vertex and plaquette stabilizers"
)
接下来分析两种稳定子的具体电路构造。在#ref(<stab-circuit>)a 中可以看到 $Z$ 型稳定子的实现，在中心会有一个辅助比特(ancilla qubit)用于测量，该投影测量会强迫临近四个数据比特进入该稳定子 $Z_a Z_b Z_c Z_d$ 的本征态中，即 $Z_a Z_b Z_c Z_d ket(psi)=Z_(a b c d)ket(psi), Z_(a b c d)=pm 1$，显然当辅助比特的测量结果为 $ket(0)$ 时，表征本征值为$+1$，反之为 $-1$。在#ref(<stab-circuit>)b 中可以看到 $X$ 型稳定子的类似实现，以将数据比特投影到 $X_a X_b X_c X_d$ 的本征态中。

注意到#ref(<stab-circuit>)a 中额外施加了一个 $I$ 门，这是为了与#ref(<stab-circuit>)b 中施加的 Hadamard 门保持同步，减少测量时间不匹配导致的误差。
#figure(
    image("img/img5.png", width: 60%),
    caption: [$X \& Z$ stabilizers quantum circuit construction]
)<stab-circuit>

根据定义，要构成一个稳定子群，这些稳定子必须相互对易。显然 $X$ 型稳定子之间是对易的，$Z$ 型稳定子之间也是对易的。而 $X$ 型稳定子与 $Z$ 型稳定子之间总是有零或两个重合的边。
#thm(
    [在上述表面码结构中，$X$ 型稳定子与 $Z$ 型稳定子总是对易的。],
    proof: [
        若二者没有重合边，则它们的作用在数据比特上是完全独立的，显然对易；若二者有两个重合边，即测量同样两个数据比特，假设 $a,c$ 为重合边，则有
        $ 
        (X_a X_b X_c X_d)(Z_a Z_e Z_c Z_f) &= (X_a Z_a) tensor X_b tensor Z_e tensor (X_c Z_c) tensor X_d tensor Z_f \
        &= -(Z_a X_a) tensor Z_e tensor X_b tensor -(Z_c X_c) tensor Z_f tensor X_d \
        &= (Z_a Z_e Z_c Z_f)(X_a X_b X_c X_d). \
        $
        简单来看，$X_a, Z_a$ 与 $X_c, Z_c$ 两对反对易算子相互抵消，结果是 $X$ 型稳定子与 $Z$ 型稳定子相互对易。
    ]
) 

当然，$X$ 型稳定子与 $Z$ 型稳定子是完全对称的。在#ref(<dual-lattice>)左可以看到，$X$ 型稳定子的组合会构成格(lattice)中的环(loops)；对于 $Z$ 型稳定子，我们以每条边的中点为心将每条边旋转90°（灰色虚线表征旋转后的结果），这样就将面和顶点进行了交换，紫色实线即为三个 $Z$ 型稳定子的组合结果，显然与左图结构是一致的。形式上，这被称作在对偶格(dual lattice)中表示算子。
#figure(
    grid(
        columns: 2,
        column-gutter: -5em,
        align: horizon,
        [#image("img/img6.png", width: 60%)],
        [#image("img/img7.png", width: 60%)]
    ),
    caption: "Dual Lattice"
) <dual-lattice>

=== 错误检测
往表面码中插入一些泡利 $X$ 错误，症候图和相应的错误如下：
#figure(
    image("img/img8.png", width: 40%),
    caption: [Syndrome and $X$ Error]
)
黄色顶点是与错误反对易的一些 $Z$ 型稳定子，他们是错误症候的一部分，依照#ref(<syndrome>)，其满足 $sigma_(S_i)(E) = 1$，它们通常被称为 *激励(excitations)*。

我们把这些相连的错误称为一条 *错误链(error chain)*。可以发现缺陷通常存在于错误链的端点处，因此当错误链成环时，缺陷消失，此时该错误与所有稳定子对易，即 $E in cc(cs)$。

== 逻辑比特与逻辑算子
我们如果从流形和拓扑的角度来考量表面码，就能发现它其实可以转换成一个环面，这样就能更轻易地判断一个环是平凡的（即 $M in cs$）还是非平凡的（即 $M in cc(cs)-cs$），不过在此不表。

将所有数据比特用一个逻辑态 $ket(u)_L$ 表征，辅助比特的状态 $ket(v)$ 表征症候，整个阵列的量子态即为 $ ket(psi) = ket(u)_L tensor ket(v) . $

比如对于#ref(<dual-lattice>)的左图，如果我们把红色边视作一整条错误链，其成环之后，就相当于三个 $X$ 型稳定子的组合，作用在当前的量子态上不改变任何东西。

而对于#ref(<logical-X>)左图，可以发现它不能由任何稳定子生成，并且也与所有稳定子对易，作用之后，会翻转逻辑态 $ket(u)_L$ 而不改变稳定子测量结果，其被称为一个 *逻辑 $X$ 算子($X_L$)*。右图与左图相比只是增加一些 $X$ 型稳定子，依然是一个 $X_L$。可以发现，联通左右边界或者上下边界的一条链即为一个非平凡的逻辑算子。
#figure(
    grid(
        columns: 2,
        column-gutter: -5em,
        align: horizon,
        [#image("img/img9.png", width: 60%)],
        [#image("img/img10.png", width: 60%)]
    ),
    caption: [Logical $X$ Operator]
)<logical-X>

可以发现对于图中的表面码，水平和垂直分别有两个逻辑算子 $X_(1L), Z_(1L)$ 和 $X_(2L), Z_(2L)$，因此可以编码 2 个逻辑比特；又根据#ref(<code-distance>)可知该表面码的码距为 4（因为上下联通，左右联通）。

== 具有开放边界的表面码
考虑以下版本的表面码#ref(<open-bound-sq>)，其中顶部和底部边界上的 $Z$ 型稳定子以及左侧和右侧边界上的 $X$ 稳定子现在仅作用在三个数据比特上。

我们将上下边界称为平滑边界(smooth boundaries)，将左右边界称为粗糙边界(rough boundaries)。可以看出，该表面码的码距为 5；水平方向仅有一个逻辑 $X$ 算子 $X_(L)$，垂直方向仅有一个逻辑 $Z$ 算子 $Z_(L)$，因此可以编码 1 个逻辑比特。此时 $X_L$ 必须连接粗糙边界，而 $Z_L$ 必须连接平滑边界。
#figure(
    image("img/img18.png", width: 60%),
    caption: "Surface Code with Open Boundaries"
)<open-bound-sq>

= 表面码解码
根据前文纠错理论，稳定子测量后给出一个错误症候 $sigma(E)$，解码器需要根据该症候来选择一个纠错算子 $R$，使得 $R E in cs$。

假设观察到症候如下#ref(<syndrome-ex>)，并想找到一个合适的纠错算子。
#figure(
    image("img/img11.png", width: 60%),
    caption: "A Syndrome Example"
)<syndrome-ex>

产生这种症候的错误链可能有很多种，比如以下三张图
#figure(
    image("img/img12.png", width: 80%),
    caption: "Possible Errors"
)
假设真实错误是第一张图，而我们选择纠错算子为第二张图，作用结果相当于一个稳定子，纠错成功。但如果选择第三张图做纠错，作用结果如#ref(<fail-correct>)，黄色边代表纠错算子。显然这是一个逻辑 $X$ 算子，纠错失败，将产生一个逻辑错误。
#figure(
    image("img/img13.png", width: 45%),
    caption: "Failed Correction"
)<fail-correct>

因此解码就是找到概率最高的错误，其等价于找到符合症候的最小错误（错误链越短，发生概率越高）。对于表面码，这相当于将缺陷与最小权重链进行匹配，这完全等同于解决 _最小权重完美匹配(minimum-weight perfect matching, MWPM)_ 问题。

== MWPM 解码器
可以把解码过程分解为两个部分：
1. 使用 _Local Dijkstra_ 算法找到连接各个缺陷的最短路径，构建完全图。
2. 使用 _Blossom_ 算法或者其他更优化版本得到一组完美匹配，根据第一部分获得相应错误链构建纠错算子。

例如考虑以下解码问题：
#figure(
    image("img/img14.png", width: 50%),
    caption: "Decode Example"
)
假设噪声独立同分布，即每条边发生错误的概率相同，则两个缺陷之间的边的权重可以由二者的曼哈顿距离表征，如#ref(<mini-match>)左图所示，构建完全图并枚举所有可能的匹配以找到最小匹配。右图为对应的错误链或者纠错算子。
#figure(
    grid(
        columns: 2,
        column-gutter: -5em,
        align: horizon,
        [#image("img/img15.png", width: 60%)],
        [#image("img/img16.png", width: 50%)]
    ),
    caption: [Minimum-Weight Matching]
)<mini-match>
另外，如果数据比特发生错误的概率并不相同，例如发生 $X$ error 的概率为 $p_i$，则在图中相应边的权重应写为 $w_i = log((1-p_i)/p_i)$#footnote[Dennis, Eric, Alexei Kitaev, Andrew Landahl, and John Preskill. 'Topological Quantum Memory', 24 October 2001. https://doi.org/10.1063/1.1499754.
]。

== 旋转表面码
从解码过程可以发现，将数据比特放置在边上，而将稳定子放置在顶点和面上，非常方便将缺陷连接为完全图来做解码。现在我们可以来看一开始提及的，关于表面码的其他两种图示。

对于#ref(<another-repr>)左图，数据比特位于顶点，稳定子位于面上，这种表示被称为校正晶格(rectified lattice)。从右图可以看出二者等价。这种表示方法的优点之一是，表面码排列更为紧凑。
#figure(
    grid(
        columns: 2,
        column-gutter: -5em,
        align: horizon,
        [#image("img/img2.png", width: 60%)],
        [#image("img/img17.png", width: 75%)]
    ),
    caption: "Rectified Lattice"
)<another-repr>

取其中心部分并添加一些边界稳定子，就能得到第三种表示如#ref(<rotate-sq>)，称为旋转表面码(rotated surface code)。
#figure(
    image("img/img3.png", width: 45%),
    caption: "Rotated Surface Code"
)<rotate-sq>

== 逻辑错误率的统计模型
#def(supplement: "阈值")[
    表面码的 *阈值(threshold)* 是其物理错误率的一个临界点。当超过该阈值时，逻辑错误率随着码距增加而增大；否则，码距增加能够降低逻辑错误率，以实现容错量子计算。
]
首先需要注意的是，表面码没有单一的阈值：它很大程度上取决于我们使用的噪声通道和解码器。

通常分为三类噪声模型：
#enum(indent: 0em)[
    *代码容量模型(code-capacity model)*，其中代码的所有物理量子位都可能出现错误，但测量被认为是准确的。
][
    *现象学噪声模型(phenomenological noise model)*，每个稳定子测量存在固定的失败概率。
][
    *电路级噪声模型(circuit-level noise model)*，其中考虑了表面码的初始化和症候提取过程的电路，并假设每个量子门之后存在一定的错误概率。
]
代码容量模型的对应阈值是最容易估计的，并且可以用来粗略地了解给定表面码或解码器的性能。

当得到阈值后，也可以估计相应的逻辑错误率。
#thm(
    [对于使用 MWPM 解码器，码距为 $d$ 的表面码，其逻辑错误率近似为 $ P_L prop (p/p_("thr"))^(d_e), $ 其中 $p_("thr")$ 为阈值，$d_e = ceil(d/2)$。],
    proof: [
        考虑#ref(<logic-error-model>)中的症候，其最可能与次可能错误链如图左与图右所示，若实际发生的错误是右图，使用 MWPM 解码器总会给出如图左的纠错算子，此时发生逻辑错误。该错误链的链长就为 $d_e$。

        当然可能对更长的错误链发生错误识别，由于发生概率与链长成指数关系，因此是小量可以暂不考虑。

        则将求出该类型错误链的发生概率即可得到逻辑错误率
        $ P_L prop d dot upright(C)^(d_e)_d dot p^(d_e) = d dot (d!)/((d-d_e)!dot d_e !) dot p^(d_e). $

        #figure(
            grid(
                columns: 2,
                column-gutter: -6em,
                align: horizon,
                [#image("img/img19.png", width: 55%)],
                [#image("img/img20.png", width: 55%)]
            ),
            caption: "Logical Error Model"
        )<logic-error-model>
    ]
)


= 表面码逻辑运算
== Pauli Frame Tracking #footnote[https://pennylane.ai/compilation/pauli-frame-tracking]
#def(supplement: "Pauli Frame Tracking")[
    $ ket(psi_"phys") = F ket(psi_"ideal"). $
    - $ket(psi_"ideal")$: 理想或者目标量子态。
    - $ket(psi_"phys")$: 实际物理量子态。
    - $F$: 已知的 $n$ 比特 Pauli 算子，称为 *Pauli frame* 或 *Pauli record*。
]
*Pauli frame tracking* 的核心是量子态只需要在已知 Pauli 误差意义下正确，只要 $F$ 已知，就不要求物理态严格等于理想态。即不立即修正已知 Pauli 误差，而是在经典侧持续记录它对后续门和测量的影响。

#lemma(supplement: " Clifford Hierarchy")[
    1. $C_1 = cp_n$，即 Clifford 层级的第一层是 Pauli 群。
    2. $C_2 = cal(N)(cp_n)$，即 Clifford 层级的第二层是 Pauli 群的正规化子，满足 $C_2 = {U | U^dagger P U in cp_n, forall P in cp_n}$。主要有 $H$, $S$, $"CNOT"$, $"CY"$, $"CZ"$ 和 $"SWAP"$ 等门。
    3. $C_3 = {U | U^dagger P U in C_2, forall P in cp_n}$。主要有 $T$, $"Toffoli"$ 和 $"CCZ"$ 等门。
    4. ...
]

#thm( supplement: "Pauli record 的更新规则", 
    [
        1. 初始化 qubit 为 $ket(0)$, $F$ 更新为 $I$。
        2. 对 qubit 的测量结果需要根据测量基的选择和 Pauli record 来纠正：
            - 测量 $Z$ 基时，若 $F$ 为 $X$ 或 $X Z$，则测量结果翻转，否则不变。
            - 测量 $X$ 基时，若 $F$ 为 $Z$ 或 $X Z$，则测量结果翻转，否则不变。
            也就是当 $F$ 与测量基反对易时，测量结果翻转。
        3. 当施加 Pauli 门时，不在物理上施加，更新 Pauli record: $F'<-F Q.$
        4. 当施加 Clifford 门时，在物理上施加，并更新 Pauli record: $F'<-C F C^dagger.$
        5. 当施加 non-Clifford 门时，在物理上施加 Pauli record 并重置 $F$ 为 $I$（称为 _flushing_），然后施加该 non-Clifford 门。
    ],
    proof: [
        1. 测量 Pauli observable $M$：在物理态测量 $bra(psi_"phys") M ket(psi_"phys")$，等价于在理想态测量 $bra(psi_"ideal") F^dagger M F ket(psi_"ideal")$，也就是 $F^dagger M F$，因此测量结果翻转与否取决于 $F$ 与 $M$ 是否对易。
        2. 施加 Pauli 门 $Q$：如果不在硬件施加 $Q$，而要求理想态已施加 $Q$，即 $ket(psi_"ideal"^') = Q ket(psi_"ideal")$，则有 $ ket(psi_"phys")=F' ket(psi_"ideal"^')=F'Q ket(psi_"ideal") = F ket(psi_"ideal"). $ 因此就可以取 $F' = F Q^dagger = F Q$。
        3. 施加 Clifford 门 $C$：更新 Pauli record 并不能模拟 Clifford 门的作用，因此必须做物理执行，但由于 Clifford 算子是 Pauli 群的正规化子，因此 Pauli frame 依然可以继续跟踪。$ C ket(psi_"phys") = C F ket(psi_"ideal") = (C F C^dagger) C ket(psi_"ideal"). $ 有新 record $F' = C F C^dagger$。
        4. 施加 non-Clifford 门 $V$：non-Clifford 的定义表明存在某个 $F$ 使得 $V F V^dagger in.not cp_n$，则更新后的“误差”不能用 Pauli record 来跟踪，因此必须在物理上施加 Pauli record，并重置 $F$ 为 $I$，再施加 $V$。 
    ]
)

#figure(
    image("img/img22.png", width: 100%),
    caption: "Pauli Frame Tracking Example"
)<pauli-frame>

=== 对纠错的意义
由于 syndrome extraction 之后的 error decoding 阶段要比给量子比特施加物理门要慢得多，维护 Pauli record 相当于异步执行，避免在完成纠错之后才能施加物理门的阻塞问题。

也就说对于尚未确定或者已确定但尚未物理修正的 Pauli 错误 $P$，有 $ket(psi_"phys") = P ket(psi_"ideal")$，可以直接执行 Clifford 门而不需要 decoder 给出纠错结果，稍后再记录 Pauli record $F = C P C^dagger$ 即可。同时也避免了在物理上施加 Pauli 门可能引入的额外误差。

当然，对于 non-Clifford 门，需要在施加前做 flush，完成一次同步。



== Logical Operations in Planar-based Surface Code #footnote[Fowler, Austin G., Matteo Mariantoni, John M. Martinis, and Andrew N. Cleland. 'Surface Codes: Towards Practical Large-Scale Quantum Computation'. Physical Review A 86, no. 3 (September 27, 2012): 032324. https://doi.org/10.1103/PhysRevA.86.032324.]
=== Transversal Operation
对于 Planar-based Surface Code，每个逻辑比特定义在独立的一块 patch 上，一种实现 $"CNOT"_L$ 的方法为 *Transversal Operation*，即让一对逻辑比特上的每对物理比特都作用一个 $"CNOT"$ 门。其结果是可能让表面码失去 *nearest-neighboring(NN)* 优势。
#[
    #show figure.caption: it => align(center)[
        #block(width: 80%)[
            #set align(left)
            #it
        ]
    ]
    #figure(
        image("img/img23.png", width: 80%),
        caption: [Transversal logical $"CNOT"$ operation between two planar logical qubits. The pink interactions denote $"CNOT"$ operations between pairs of physical qubits. Syndrome qubits have been suppressed for clarity.]
    )<transversal-CNOT>
]
=== Lattice Surgery
// *本质是通过改变稳定子测量集合，在相邻逻辑 patch 的边界上执行联合逻辑 Pauli 测量。也就是增删稳定子约束。*

// 两个独立 patch 原本各编码一个逻辑比特，总编码维数为 2。merge 时，在两个 patch 之间打开新的联合稳定子测量，其中一个独立联合约束等价于测量 $dash(X)_1 dash(X)_2$ 或 $dash(Z)_1 dash(Z)_2$，因此增加一个独立稳定子约束，总维数变为 1。split 则关闭跨边界稳定子，并测量中间一排数据比特，使一个 patch 变成两个 patch，总维数从 1 变为 2。但新出现的逻辑自由度并不是任意未知态，而是由测量结果和原始逻辑态固定，因此不会凭空产生量子信息。

==== Merge
#[
    #show figure.caption: it => align(center)[
        #block(width: 80%)[
            #set align(left)
            #it
        ]
    ]
    #figure(
        image("img/img24.png", width: 80%),
        caption: [Arrangements of physical qubits for rough lattice merging. Left and right continuous surfaces encode separate logical qubits. The extra pink qubits form the intermediate qubit line for the merging operation.]
    )<rough-merge>
]
*Rough merge*#footnote[延续先前的设置，将 $Z$ 稳定子放置在顶点上，$X$ 稳定子放在面心，从而水平方向连接 rough boundary，为 $X_L$ 逻辑算子；垂直方向连接 smooth boundary，为 $Z_L$ 逻辑算子。] 的操作如下：如 #ref(<rough-merge>) 所示，两个表面码块各编码一个独立的逻辑比特，中间一列未初始化的物理比特，按照合并后的表面码结构排列辅助比特和数据比特。将中间数据比特初始化到 $ket(+)$ 态，进行 d 轮纠错，也就是测量稳定子，将整个系统当作一个表面码块来处理纠错。

我们将如 #ref(<rough-merge>) 所示的 rough boundary 上的表面码合并称为 *rough merge*；smooth boundary 上的同理称为 *smooth merge*，但中间比特需初始化为 $ket(0)$ 态。

注意，为了获得合并后的逻辑测量结果，需要新增列稳定子（与粉色 data qubits 交错排列的 ancilla qubits）的第一轮测量结果，后续 d-1 轮用于纠错与保护第一轮测量结果。接下来对合并过程发生的事件进行说明。

#[
    #show figure.caption: it => align(center)[
        #block(width: 80%)[
            #set align(left)
            #it
        ]
    ]
    #figure(
        image("img/img25.png", width: 80%),
        caption: [Lattice qubits for merging two smooth surfaces of distance 2 into a single surface.]
    )<smooth-merge-demo>
]

如 #ref(<smooth-merge-demo>) 所示，新增两个稳定子 $ S_1^X = X_2 X_M X_a, quad S_2^X = X_5 X_M X_d, $ 其组合结果为 $ S_1^X S_2^X = X_2 X_5 X_a X_d = X_L^1 X_L^2, $ 由于 $X_2 X_5$ 连接了 rough boundary，其正是 $X_L$ 逻辑算子。也就是说，第一次对这两个稳定子的测量，等价于测量 $X_L^1 X_L^2$，即合并后的逻辑测量结果为两个稳定子测量结果的乘积 $ M_(X X) = s_1 s_2. $

首次测量之后发生了两件事：1. 由于 $ket(0)$ 不是 $X$ 稳定子的本征态，因此测量后 qubit $M$ 会随机落在 $ket(+)$ 或 $ket(-)$ 上，测量后的逻辑态不确定，并且与测量结果关联；2. 合并后的表面码块的逻辑自由度减少为 1，因此需要将合并前的逻辑态映射到合并后的。

#rm[
    为什么选择初始化为 $ket(0)$：

    不确定的叠加态 $gamma ket(0) + delta ket(1)$ 将引入新的变量，导致输出的逻辑态依赖于这两个未知系数，无法确定输出逻辑态的具体形式；若选择 $ket(+)$，确定性的测量结果相当于将原逻辑态进行 X 投影测量，可能破坏逻辑信息。
]

设合并前的逻辑态为 $ket(psi) = alpha ket(0)_L + beta ket(1)_L, quad ket(phi) = alpha' ket(0)_L + beta' ket(1)_L$，两比特输入态 $ket(Psi)=ket(psi)ket(phi)$；设 $M=M_(X X)=s_1 s_2$ 为 $X_L^1 X_L^2$ 逻辑测量结果，对应的投影算符为 $ P_M = (I+(-1)^M X_L^1 X_L^2)/2. $

则归一化后的测后状态为 $ ket(Psi_M) = (P_M ket(Psi))/sqrt(p_M) = (ket(psi)ket(phi) + (-1)^M ket(macron(psi))ket(macron(phi)))/(2 sqrt(p_M)), $

其中 $ket(macron(psi)) = sigma_X ket(psi)$，$p_M = bra(Psi) P_M ket(Psi).$

现在对上式进行展开，不关心全局系数，并设 $lambda = (-1)^M$，有：$ ket(psi)ket(phi) + lambda ket(macron(psi))ket(macron(phi)) = &(alpha alpha' + lambda beta beta' )ket(00) + \ &(alpha beta' + lambda beta alpha' )ket(01) + \ &(beta alpha' + lambda alpha beta' )ket(10) + \ &(beta beta' + lambda alpha alpha' )ket(11). $ 则有测量结果 $M=0$ 时，上式化为：$ (alpha alpha' + beta beta')(ket(00) + ket(11)) + (alpha beta' + beta alpha')(ket(01) + ket(10)), $ 测量结果 $M=1$ 时：$ (alpha alpha' - beta beta')(ket(00) - ket(11)) + (alpha beta' - beta alpha')(ket(01) - ket(10)). $ 这是测量后的逻辑态与测量结果和测量前的逻辑态之间的关系。

另一方面，我们想要得到合并前后的逻辑态之间的映射。新逻辑基态 $ket(0)_"new"$ 需要满足两个约束：1. 属于 $X_L^1 X_L^2$ 的 $lambda=(-1)^M$ 本征值空间；2. $ket(0)_"new"$ 应属于 $Z_L^1 Z_L^2$ 的偶子空间，$ket(1)_"new"$ 应属于 $Z_L^1 Z_L^2$ 的奇子空间。

显然 $"span"(ket(00), ket(11))$ 是 $Z_L^1 Z_L^2=+1$ 的偶子空间，$"span"(ket(01), ket(10))$ 是 $Z_L^1 Z_L^2=-1$ 的奇子空间。因此可以设 $ ket(0)_"new" = a ket(00) + b ket(11), quad ket(1)_"new" = c ket(01) + d ket(10), $ 再根据约束 1，有 $ X_L^1 X_L^2 ket(0)_"new" = lambda ket(0)_"new", $ 即 $ a ket(11) + b ket(00) = lambda (a ket(00) + b ket(11)), $ 从而得到 $a = lambda b$ 和 $b = lambda a$，再根据归一化条件，最终得到 $ ket(0)_"new" &-> 1/sqrt(2)(ket(00) + (-1)^M ket(11)), \ ket(1)_"new" &-> 1/sqrt(2)(ket(01) + (-1)^M ket(10)). $

代回前式，可以得到测量后的逻辑态也可以写为：$ ket(Psi_M) = (alpha alpha' + (-1)^M beta beta')ket(0)_"new" + (alpha beta' + (-1)^M beta alpha')ket(1)_"new". $ 又 $ket(psi) = alpha ket(0)_L + beta ket(1)_L, quad ket(phi) = alpha' ket(0)_L + beta' ket(1)_L$，我们使用 $mergeop$ 作为 merge 操作符号，有 
$ ket(psi) mergeop ket(phi) = alpha ket(phi) + (-1)^M beta ket(macron(phi)) = alpha' ket(psi) + (-1)^M beta' ket(macron(psi)). $ 当然等式左边是在 $ket(0)_L$ 逻辑基态下的，而右式是在 $ket(0)_"new"$ 逻辑基态下的，二者只是形式上能满足等号。

基于上式，不难发现 merge 操作类似异或，输入 $ket(00)$ 和 $ket(11)$ 时，输出为 $ket(0)_"new"$；输入 $ket(01)$ 和 $ket(10)$ 时，输出为 $ket(1)_"new"$。

==== Split
#[
    #show figure.caption: it => align(center)[
        #block(width: 80%)[
            #set align(left)
            #it
        ]
    ]
    #figure(
        image("img/img26.png", width: 80%),
        caption: [Lattice qubits for splitting a single surface into two distance-2 rough qubit surfaces.]
    )<rough-split-demo>
]
*Rough split* 的操作如下：1. 在 X basis 上测量中间一列数据比特；2. 停止沿分割线的 Z 稳定子；3. 在两条 rough boundaries 上的 X 稳定子从连接四个 data qubits 变为三个；4. 分别对两个新的表面码块进行 d 轮纠错。

为了保留后续边界上变为三体的 X 稳定子，需要在 X basis 上测量。考虑一个切割前的 X 稳定子 $A_p = X_2 X_3 X_5 X_M$，因为 $[A_p, X_M] = 0$，二者兼容，也就是对 $X_M$ 的测量不会破坏 $A_p$ 的稳定子约束。设 $X_M ket(Psi_M) = x_m ket(Psi_M)$，显然可以得到 $ X_2 X_3 X_5 ket(Psi_M) = X_M ket(Psi_M) = x_m ket(Psi_M), $ 因此三体边界稳定子 $X_2 X_3 X_5$ 的本征值由 $x_m$ 确定，若 $x_m=-1$，可以在 Pauli frame 上记录一个修正。

显然在分裂前，可以在左右两侧画出平行的 $Z_L^1$ 和 $Z_L^2$ 两条平行逻辑 Z 链，二者是同一个逻辑算符 $Z_L^"init"$ 的两种表示。分裂后 $Z_L^1$ 和 $Z_L^2$ 仍继承了 $Z_L^"init"$ 的本征值，因此对于逻辑零态 $Z_L^"init" ket(0)_"init" = + ket(0)_"init"$，有 $Z_L^1 = +1, Z_L^2 = +1$，即分裂后的基态为 $ket(0)ket(0)$；同理可得到 $ket(1)_"init"$ 分裂后为 $ket(1)ket(1)$。因此有映射 $ alpha ket(0) + beta ket(1) -> alpha ket(00) + beta ket(11). $

==== Universal Gate Operations
/ CNOT gate: 准备 Control qubit $ket(C)$, Target qubit $ket(T)$，以及 Ancilla qubit $ket(+)$。总体操作 $ M_(Z Z)(C, A) -> "split" -> M_(X X)(A, T) $

#[
    #show figure.caption: it => align(center)[
        #block(width: 80%)[
            #set align(left)
            #it
        ]
    ]
    #figure(
        image("img/img30.png", width: 80%),
        caption: [Layout of qubits for a CNOT operation with lattice surgery. Control (C) and target (T) surfaces interact by merging and splitting with the intermediate surface (INT).]
    )<rough-split-demo>
]


/ State injection:

/ Hadamard gate:


== Logical Operations in Defect-based Surface Code
=== Braiding #footnote[https://doi.org/10.1103/PhysRevA.80.052312] (\*TBD)
#quote[
    逻辑 Pauli 算符属于一条路径，移动缺陷改变了逻辑 Pauli 算符所属的同伦类，使逻辑算符在稳定子等价意义下发生变换。
]
文章中的定义：
#table(
    columns: 5,
    inset: 5pt,
    align: (center, left, center, left, left),
    table.header(
        [逻辑比特], [如何制造缺陷], [被停止的稳定子], [逻辑 $X_L$], [逻辑 $Z_L$],
    ),
    [smooth qubit], [对缺陷内部数据比特做 $X$ 基测量], [$Z$-stabilizer], [两个 smooth 缺陷之间的 $X$ 链], [环绕任一缺陷的 $Z$ 环],
    [rough qubit], [对缺陷内部数据比特做 $Z$ 基测量], [$X$-stabilizer], [环绕任一缺陷的 $X$ 环], [两个 rough 缺陷之间的 $Z$ 链],
)

#quote[文章使用 double-defect 来编码一个逻辑比特，但事实上一个 defect 就能提供一个逻辑自由度，double-defect 类似重复码，用比如 $Z_L^1 Z_L^2=+1$ 的约束来限制了一个自由度。]
#[
    #show figure.caption: it => align(center)[
        #block(width: 80%)[
            #set align(left)
            #it
        ]
    ]
    #figure(
        image("img/img27.png", width: 50%),
        caption: [a.) Smooth defect and surface in the +1 eigenstate of $X_L$. b.) After measuring the center qubit in the $X$ basis, it is possible that three term $X$ stabilizers and $X_L$ stabilizers with negative sign are created (potential locations indicated in green). c.) All signs can be corrected by applying the appropriate single qubit Z operators and chains of $Z$ operators. d.) Measuring and possibly correcting the indicated $Z$ stabilizer using a bit-flip on the center qubit completes the movement of the defect.]
    )<rough-split-demo>
]

一个 smooth defect 移动的完整过程：
1. 扩大缺陷，对在移动路径上的 data qubit 做 $X$ 基测，使其脱离编码面，关闭与其相交的 Z stabilizer，在新边界形成三体或低权重 X-stabilizer。
2. 对新边界进行若干轮纠错。
3. 当缺陷扩大到目标位置后，需要把后方原区域重新并入编码面。
    1. 先测量最终缺陷边界外部以及边界上的所有适当 X stabilizer；
    2. 保存残余 Z 错误的 syndrome 信息；
    3. 再测量最终缺陷外部的 Z stabilizer，使尾部区域重新成为编码面；
    4. 继续纠错，使所有被拖动的 $X_L$ 有一致符号。

/ CNOT operation: CNOT 的 Pauli 共轭关系为：$ X_C &-> X_C X_T \ Z_C &-> Z_C \ X_T &-> X_T \ Z_T &-> Z_C Z_T. $ 接下来用一个 smooth qubit 作为 Control，rough qubit 作为 Target，进行 CNOT 操作。

#[
    #show figure.caption: it => align(center)[
        #block(width: 80%)[
            #set align(left)
            #it
        ]
    ]
    #figure(
        image("img/img28.png", width: 50%),
        caption: [a.) Surface containing a smooth qubit in the +1 eigenstate of $X_L$ and a rough qubit. The lower smooth defect has been braided around the upper rough defect using $X$ measurements. Note that is not possible to complete the braiding in one step as a ring of $X$ measurements corresponds to measurement of the rough qubit in the $X_L$ basis. b.) Via correction of many $Z$ stabilizers, the $X_L$ operator is dragged around the upper rough defect. c.) Additional $X$ measurements extend the defect back to its original position. d.) Further correction of $Z$ stabilizers returns the defects to their original positions but the surface is now in the +1 eigenstate of both the smooth and rough $X_L$ operator.]
    )<rough-split-demo>
]

Smooth 控制比特的 $X_C$是连接其两个 smooth 缺陷的 $X$ 链。当其中一个 smooth 缺陷绕 rough 缺陷移动时，这条 $X_C$ 链会被拖动。缺陷回到原位后，新的逻辑路径相对于原路径多出一个环绕 rough 缺陷的 $X$ 环。而环绕 rough 缺陷的 X 环正是目标比特的 $X_T$。

#[
    #show figure.caption: it => align(center)[
        #block(width: 80%)[
            #set align(left)
            #it
        ]
    ]
    #figure(
        image("img/img29.png", width: 50%),
        caption: [a.) Surface containing a smooth defect and a rough defect in the +1 eigenstate of $Z_L$. The lower smooth defect has been braided around the upper rough defect using $X$ measurements, deforming the shape of the rough $Z_L$ operator. b.) By first correcting many $Z$ stabilizers and then performing further $X$ measurements, the smooth defect can be extended back to its original position. c.) A final round of $Z$ stabilizer correction returns the defects to their original configuration but with the state of the surface changed. d.) The $Z_L$ operator shown in part c is equivalent to the tensor product of smooth and rough $Z_L$.]
    )<rough-split-demo>
]

Rough 目标比特的 $Z_T$ 是连接两个 rough 缺陷的 Z 链。smooth 缺陷绕 rough 缺陷运动时，$Z_T$ 路径必须不断避开移动中的 smooth 缺陷，因此被持续形变。完成一周后，最终的 Z 路径相对于原来的 $Z_T$，多出一个环绕 smooth 缺陷的 Z 环。


== Comparison
Braiding 优势 
1. 逻辑作用对局部路径细节不敏感
2. 拓扑直观

劣势
1. 空间占用通常明显更大
2. 路由和并行调度更困难
3. 同类型 CNOT 不直接
4. 移动边界的容错实现复杂