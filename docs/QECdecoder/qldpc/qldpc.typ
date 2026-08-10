#import "../../physics/misc/suface_code/template.typ": *
#import "@preview/physica:0.9.8": *
#show: doc => conf(doc)
#set text(
    font: serif-fonts
)
#show emph: set text(font: kai-fonts, weight: "medium")
#show strong: set text(font: sans-fonts)
#show smallcaps: set text(font: "Libertinus Serif")
#show link: set text(fill: rgb("#330fff"))

#let dd = $frak(D)$
#let nn = $upright(N)$
#let ee = $upright(E)$
#let ss = $upright(S)$
#let ww = $upright(W)$
#let cx = $upright("CX")$
#let swap = $upright("SWAP")$
#let cxswap = $upright("CXSWAP")$
#let iswap = $upright("iSWAP")$
#let tensor = $times.o$

= 二维近邻架构上的 Directional Tile Code #footnote[Gu, Boren, Tamas Noszko, Vincent Steffan, Jens Niklas Eberhardt, Joschka Roffe, Jens Eisert, and Stergios Koutsioumpas. “Nearest-neighbour gates are all you need: High-rate quantum low-density parity-check codes on a planar grid.” arXiv:2606.19482v1, 17 June 2026. https://arxiv.org/abs/2606.19482.]

== 问题：表面码的局域性与 qLDPC 的编码率
距离为 $d$ 的旋转表面码(rotated surface code, RSC)使用 $n=d^2$ 个数据比特编码一个逻辑比特，即码参数为 $[[d^2,1,d]]$。若把症候比特也计算在内，则一个 patch 需要
$ n_("RSC") (d) = 2d^2-1 $
个电路比特。其优点是所有稳定子都能用二维方格上的近邻门测量；代价则是每个逻辑比特都要占用一块独立的二维面积。

量子低密度奇偶校验码(quantum low-density parity-check code, qLDPC code)试图用一个码块同时编码多个逻辑比特。对于 CSS 码，取二元校验矩阵 $H_X,H_Z$，并要求
$ H_X H_Z^T = 0. $
$H_X$ 的每一行给出一个 $X$ 型稳定子，$H_Z$ 的每一行给出一个 $Z$ 型稳定子；上式正是两类稳定子相互对易的条件。

#def(supplement: "qLDPC")[
    若存在与码长 $n$ 无关的常数 $w,q$，使每个稳定子的权不超过 $w$，并且每个数据比特至多参与 $q$ 个稳定子，则该稳定子码称为 *qLDPC 码*。等价地说，$H_X,H_Z$ 的行重和总列重都被常数限制。
]

qLDPC 的“低密度”是 Tanner 图意义下的稀疏，并不自动等价于二维几何局域。许多参数优秀的 qLDPC 码仍需要长程校验—数据连接；若使用超导量子比特，通常就要引入长程耦合器、三维布线或者比特搬运。本文的目标是同时满足：1. 开放边界的平面布局；2. 方格上的严格近邻二比特门；3. 在实用有限尺寸下优于若干独立的表面码 patch。

#rm(supplement: "这里的 high-rate")[
    本文所说的 *high-rate* 主要是有限尺寸意义下，一个 patch 能编码 $k>1$ 个逻辑比特，并显著提高 $k d^2/n$；不能据此推出该构造已经给出 $k/n=Theta(1)$、$d$ 随 $n$ 增长的渐近好码。事实上，二维静态局域稳定子码仍受 $k d^2=O(n)$ 一类 trade-off 限制。本文解决的是近期硬件最直接的有限尺寸开销问题。
]

== 从方向词到 CSS 稳定子
=== 方向词与连通字符串
#def(supplement: "方向词")[
    一个权为 $w$ 的 *方向词(directional word)* 是方格上的有序方向序列
    $ dd = arrow(d)_1 arrow(d)_2 dots arrow(d)_w, quad arrow(d)_i in {nn,ee,ss,ww}. $
    从某条边出发依次执行这些方向步，就得到一条由 $w$ 条数据边组成的有序连通字符串。
]

这里同一个对象具有三种解释：
#enum(indent: 0em)[
    几何上，$dd$ 是方格中的一条有序路径；
][
    代数上，路径经过的数据边构成一个稳定子的支撑集；
][
    电路上，方向的先后顺序给出测量该稳定子的近邻门调度。
]
这正是该构造最重要的设计：*码的连接关系与测量电路不是分别设计的，而是由同一个方向词同时定义。*

论文的一个基本例子为
$ dd = nn^2 ee ss ee nn^2, quad w=7, $
记作 `N²ESEN²`。将这一连通字符串放在原格(primal lattice)上得到 $X$ tile，再把同样的字符串放在对偶格(dual lattice)上得到 $Z$ tile。数据比特位于边上，$X$ 型校验比特位于顶点，$Z$ 型校验比特位于面心，这一点与通常的未旋转表面码很相似；区别在于一个稳定子的支撑不再只是顶点或面周围的四条边，而是方向词给出的连通字符串。

=== Directional tile 的相容条件
设 tile 位于 $B times B$ 方格中。为了保证所得 $X,Z$ 稳定子对易，$X$ tile 和 $Z$ tile 首先要满足 *mutual condition*：若 $X$ tile 含有坐标为 $(a,b)$ 的水平（垂直）边，则 $Z$ tile 含有关于 tile 中心反射后坐标 $(B-1-a,B-1-b)$ 的垂直（水平）边。

这个静态条件只保证校验矩阵满足 $H_X H_Z^T=0$，却不保证沿路径执行的动态症候电路是确定的。为此还需要定义位移向量：从有序字符串中较早的一条边指向较晚的一条边所得的向量。若某位移向量的垂直分量为奇数，则该向量必须在全部有序边对中出现偶数次。

#def(supplement: "Directional tile")[
    一对 $X,Z$ tile 称为 *directional*，当且仅当：
    1. 二者满足 mutual condition；
    2. 一个 tile 是由方向词 $dd$ 标记的有序连通字符串，另一个在对偶格上包含相同字符串；
    3. 每个具有奇数垂直分量的位移向量都以偶数重数出现。
]

条件 1 保证“想要测量的稳定子彼此对易”，条件 3 保证“实际执行的交换电路确实确定性地测量这些稳定子”。这两层条件不能混为一谈。

=== 开放边界与平面码块
在 $(M+B-1) times (N+B-1)$ 的矩形方格中，选取 $M times N$ 个锚点(anchor)，并在每个 bulk anchor 平移放置一对 $X,Z$ tile。边界处分别放置截断的 $X$ tile 与 $Z$ tile，再作如下裁剪：若某条边至多只被一种 tile 覆盖，就删除该边；支撑变为空集的稳定子也一并删除。剩余的边是数据比特，剩余的 tile anchor 是校验比特，由此得到一个具有开放边界的 CSS 码。

与表面码相同，逻辑算子表现为连接相对边界的链。因而 $d_X$ 主要由水平方向的 bulk 尺寸 $M$ 控制，$d_Z$ 主要由垂直方向的 $N$ 控制。改变长宽比就可以构造 $d_X != d_Z$ 的非对称码，以适配 biased noise。

#lemma(
    [对周期边界的 toric directional code，若方向词权为 $w$，则每个稳定子权为 $w$，每个数据比特总共参与 $w$ 个 $X/Z$ 稳定子，即 Tanner 图在 bulk 中为 $(w,w)$-regular。开放边界只会降低相应的权，因此该码族是 qLDPC。],
    proof: [
        将一条方向字符串的水平与垂直支撑分别编码为二元多项式 $f(x,y),g(x,y)$，令 $w_f=abs("supp"(f)), w_g=abs("supp"(g))$，则 $w=w_f+w_g$。周期平移矩阵 $bb(B)(f)$ 与 $bb(B)(macron(f))$ 的行重、列重均为 $w_f$，$g$ 对应的矩阵同理均为 $w_g$。因此
        $ H_X = [bb(B)(f) | bb(B)(g)], quad H_Z=[bb(B)(macron(g)) | bb(B)(macron(f))] $
        的每一行权为 $w_f+w_g=w$，每个数据列在两类校验中的总列重也为 $w$。截取开放边界不会增加任何行重或列重。
    ]
)

== 近邻 iSWAP 症候提取
=== CXSWAP 同时完成测量与移动
普通稳定子测量用 $cx$ 把多个数据比特的奇偶性累积到校验比特；但当二者不相邻时，仅有 $cx$ 还不够。这里使用
$ cxswap(q_0,q_1) = swap(q_0,q_1) cx(q_0,q_1) $
将这两件事合并：$cx$ 部分累积稳定子本征值，$swap$ 部分把量子信息沿方向词向前移动。该门与超导平台自然支持的 $iswap$ 只相差单比特 Clifford 门：
$ cxswap(q_0,q_1) = (S^dagger tensor H S^dagger) iswap(q_0,q_1) (H tensor I). $
因此每一步都只需要方格上的近邻 $iswap$ 与单比特门，并不要求校验比特与其完整支撑集之间存在静态硬件连边。

=== 一轮测量
给定 $dd=arrow(d)_1 dots arrow(d)_w$，记数据、$X$ 校验、$Z$ 校验和路由比特集合分别为 $D,C_X,C_Z,R$。一轮症候提取为：
#enum(indent: 0em)[
    将 $C_X$ 初始化为 $ket(+)$，将 $C_Z$ 初始化为 $ket(0)$；
][
    对 $i=1,dots,w$，所有校验比特并行地向 $arrow(d)_i$ 方向走一步；
][
    若 $X$ 校验遇到数据比特，执行 $cxswap(C_X,D)$；若 $Z$ 校验遇到数据比特，执行 $cxswap(D,C_Z)$；
][
    若下一位置为路由比特，则通过 $swap$ 继续移动量子态。路由比特初始化为 $ket(0)$ 时，在相关输入子空间中可用同一个原生门实现
    $ swap(ket(0)_R,q)=cxswap(ket(0)_R,q); $
][
    最后在 $X$ 基测量 $C_X$，在 $Z$ 基测量 $C_Z$。
]
相邻两轮交替使用 $dd$ 与其逆词，使第一轮移动后的量子信息在下一轮沿反向路径返回，不需要额外的长程复位操作。

#thm(
    [权为 $w$ 的方向词可以在深度 $w$ 内完成全部数据—校验相互作用；计入校验比特的初始化与测量，总深度为 $w+2$，且与码长 $n$ 无关。],
    proof: [
        方向词的第 $i$ 个字符对应一层互不冲突的近邻二比特门，同一层中的所有校验路径并行执行，因此 $w$ 个字符给出 $w$ 个二比特门层。初始化和末端测量各增加一层，得到 $w+2$。另一方面，一个权为 $w$ 的稳定子至少要让校验信息与 $w$ 个数据支撑发生相互作用；单个校验比特在同一二比特门层只能参与一次相互作用，所以二比特门深度不可能小于 $w$。故该深度在此测量模型下是最优的。
    ]
)

=== 错误传播与 leakage
交换会让“数据比特”“校验比特”成为随时间变化的逻辑角色，而不是固定的物理位置。每一轮之后二者角色互换，因此每个物理比特每隔一轮就有机会作为校验比特被测量并重置；这为清除超导系统中的非计算能级布居(leakage)提供了自然接口。路由比特也可以在适当时刻重置或测量，其非平凡结果能作为 flag 交给解码器，提示路径上可能发生的故障。

但这并不意味着单个故障不会传播。论文给出的保证是传播仍被方向词的常数权限制：每轮中每个数据或校验比特最多参与 $w$ 个二比特相互作用。因此当 $w$ 固定时，单故障的影响范围不会随码长增长。需要注意，论文的数值噪声模型没有直接模拟 leakage；这里得到的是电路结构上的兼容性，而不是 leakage 下的阈值结论。

== 路由开销
开放边界截断了完整的周期路径，一些边界校验比特与其下一交互位置之间会出现空隙。为保持每一步都是近邻门，需要在这些空隙中放置路由比特(routing qubits)。它们不属于码参数 $[[n,k,d]]$ 中的 $n$，但必须计入实际硬件占用 $n_("circ")$。

#lemma(
    [固定方向词和 tile 尺寸，并要求矩形 patch 的长宽比有界，则路由比特数满足 $n_r=O(sqrt(n))$。对于 $d_X,d_Z$ 可比的 balanced family，还有 $n_r=O(d)$。],
    proof: [
        设包含边界余量的水平、垂直长度为 $L_h=M+O(1)$ 与 $L_v=N+O(1)$。顶点、边和面心上的硬件位置总数为
        $ n_("hw")=4 M N+O(M+N). $
        bulk 中有 $M N$ 个 $X$ anchor 与 $M N$ 个 $Z$ anchor；相应稳定子独立，所以至少还有 $2 M N$ 个数据比特。数据和校验比特合计占用至少 $4 M N$ 个位置，故剩余路由位置
        $ n_r <= n_("hw")-4 M N=O(M+N). $
        当长宽比有界时，$M+N=O(sqrt(M N))$ 且 $n=Theta(M N)$，从而 $n_r=O(sqrt(n))$。又由于逻辑算子连接边界，$d_X,d_Z$ 分别随 $M,N$ 线性变化，balanced family 中即有 $n_r=O(d)$。
    ]
)

论文还使用两种边界优化：*route-window shortening* 删除某个边界稳定子首次与末次有效交互之外的无用路径前后缀；*trace pruning* 则移动起点并迭代删除不承载两次有效交互之间量子态的末端路由点。每次修改后都重新验证稳定子支撑、detector、逻辑可观测量以及 detector error model 的确定性。

#eg(supplement: [$[[323,14,15]]$ 码的路由优化])[
    对方向词 `N²E²SESE²N²`（$w=11$）构造的 $[[323,14,15]]$ 码，未优化布局有 $346$ 个路由比特。route-window shortening 将其降至 $235$，继续 trace pruning 后降至 $165$，共删除 $181$ 个，约为原路由开销的 $52%$。
]

== 参数与性能比较
=== 两种效率指标
#def(supplement: "码效率与电路效率")[
    对 $[[n,k,d]]$ 码，定义
    $ eta_("code") = (k d^2)/n. $
    它只比较数据比特；$[[d^2,1,d]]$ 旋转表面码恰有 $eta_("code")=1$。

    若把数据、校验与路由比特全部计入，定义
    $ eta_("circ") = (k n_("RSC")(d))/(n_("circ")), quad n_("RSC")(d)=2d^2-1. $
    它表示实现该码块所用电路比特数，相对于实现 $k$ 个同距离旋转表面码 patch 的节省比例。
]

两者回答的是不同问题。高 $eta_("code")$ 可能被大量症候或路由比特抵消；只有 $eta_("circ")>1$ 才说明近邻编译后仍节省硬件。下表列出论文中的代表性实例：

#figure(
    table(
        columns: (1.8fr, 0.8fr, 1.15fr, 0.8fr, 0.9fr),
        inset: 5pt,
        align: (left, center, center, center, center),
        table.header(
            [方向词], [$w$], [码参数], [$eta_("code")$], [$eta_("circ")$],
        ),
        [`N²ESEN²`], [$7$], [$[[60,4,5]]$], [$1.67$], [$1.34$],
        [`N²E²SE²N²`], [$9$], [$[[217,10,7]]$], [$2.26$], [$1.74$],
        [`N²E²SESE²N²`], [$11$], [$[[323,14,15]]$], [$9.75$], [$7.89$],
        [`N²E²SE³SE²N²`], [$13$], [$[[248,20,11]]$], [$9.76$], [$7.37$],
    ),
    caption: "Representative directional tile codes",
)<representative-codes>

以 $[[323,14,15]]$ 为例，与 14 个距离 15 的旋转表面码相比：后者需要
$ 14 dot (2 dot 15^2-1)=14 dot 449=6286 $
个电路比特；directional tile code 的优化布局需要 $797$ 个，因此
$ eta_("circ") = 6286/797 approx 7.89. $
这里 $797=323+309+165$，依次为数据比特、独立校验比特与路由比特。也就是说，该例近十倍的码效率在加入完整测量硬件后仍保留了约 $7.9$ 倍的面积优势。

=== 电路级模拟
论文在统一电路级 depolarising noise 下进行四轮 memory experiment：二比特 Clifford、单比特 Clifford、reset、measurement 与 idle 均以概率 $p$ 发生相应 Pauli 错误；取 $p=10^(-3)$，每个电路最多采样一千万次，或观察到 30 次逻辑错误时提前停止。电路由 Stim 生成，使用 VibeLSD 解码器。

为了公平比较，作者固定总共存储 140 个逻辑比特：分别使用 140 个旋转表面码 patch，或者使用若干个 $k=4,10,14,20$ 的 directional tile-code patch。逻辑错误率归一化为“每逻辑比特、每症候轮”。在约 30 个电路比特/逻辑比特的 footprint 附近，最佳 directional tile-code 布局相对旋转表面码最多降低约三个数量级。

#rm(supplement: "如何阅读数值结果")[
    该结果证明的是：在作者选取的有限尺寸、四轮 memory circuit、$p=10^(-3)$ 统一 Pauli 噪声与指定解码器下，优势在完整近邻编译后仍存在。它不是阈值曲线，也没有覆盖 leakage、串扰、门时长差异或真实器件上的 coherent noise。大码的低错误率还受“观察到 30 次逻辑错误即停止”的有限统计量影响。因此三个数量级应视为特定 footprint 上的数值比较，而非对任意噪声与任意尺度的普遍保证。
]

== 与表面码的关系及评价
从几何上看，directional tile code 保留了表面码的三个重要特征：数据比特仍放在边上，$X/Z$ 校验分别使用原格与对偶格，逻辑算子仍连接相对边界。它真正改变的是稳定子的形状以及症候提取中的时间维：表面码依靠静态的四体局域邻接，directional tile code 则让校验信息沿一条常长路径移动，在移动中生成所需邻接。

因此这项工作的结论可以归纳为
$ "静态二维连接不足" space arrow.r space "在时空中用交换动态生成连接". $
只要方向词权 $w$ 固定，稳定子权、每比特参与的校验数和每轮电路深度就都保持为常数；开放边界引入的额外路由开销又只随边界而不是面积增长。于是一个 patch 可以同时保护多个逻辑比特，并在实际有限距离上比多个独立表面码 patch 更紧凑。

但仍有四个问题尚未由本文解决：
#enum(indent: 0em)[
    *渐近参数*：当前结果以有限尺寸搜索为主，不能从表中外推常数编码率或渐近距离；
][
    *阈值与真实噪声*：只模拟 $p=10^(-3)$ 附近的统一 Pauli 电路噪声，尚无包含 leakage 等误差的完整阈值研究；
][
    *解码复杂度*：较长的方向路径和 routing detector 产生比表面码更稠密的 detector error model，经典解码吞吐量仍需评估；
][
    *逻辑运算*：论文讨论了通过 derived automorphism、反射重标号以及 lattice-surgery padding 实现 Clifford 操作的可能性，但主体数值结果仍是 quantum memory，而非完整的通用容错计算架构。
]

总体而言，该编码的价值并非在抽象码参数上再次击败表面码，而是在编译层面给出一个完整反例：*qLDPC 的有限尺寸优势不必在严格二维近邻硬件上消失。*方向词把稳定子支撑、硬件路径与测量调度绑定为同一个可搜索对象，使之后的优化问题自然变成码—布局—电路—解码器的联合设计。
