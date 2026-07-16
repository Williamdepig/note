#import "@local/mathnote:0.1.0": *
#import "@preview/ilm:1.4.1": *
#import "@preview/physica:0.9.6": *

#show: ilm.with(
  title: [Neural network decoder],
  author: "Williamdepig",
  // date: datetime(year: 2025, month: 08, day: 08),
  date: datetime.today(),
  abstract: [
    Note by Williamdepig
  ],
  // preface: [
  //   #align(center + horizon)[
  //     Thank you for using this template #emoji.heart,\ I hope you like it #emoji.face.smile
  //   ]
  // ],
  // bibliography: bibliography("refs.bib", style: "ieee"),
  // figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
  paper-size: "a4",
  
  // table-of-contents: none
)
// = 使用说明
// == 数学环境块
// 1. 定义: `#def[]`
// 2. 定理: `#thm([], proof: [])`
// 3. 引理: `#lemma([], proof: [])`
// 4. 命题: `#prop([], proof: [])`
// 5. 例: `#eg[]`
// 6. 注记: `#rm[]`
// 7. 猜想: `#conj[]`
// 8. 推论: `#coro[]`
// 9. 习题: `#ex([], solution: [])`

// == 额外环境块
// 1. 强调: `#emph-box[]` 
// 2. 引用: `#quote-box[]`
// 3. 注意: `#note-box[]`
// 4. 建议: `#tip-box[]`
// 5. 关键: `#important-box[]`
// 6. 警告: `#warning-box[]`
// 7. 负面: `#caution-box[]`
#set par(first-line-indent: 0em)

#let ar(xi) = $arrow(xi)$
#let tht = $theta$
#let sig = $sigma$
#let al = $alpha$
#let SU(xi) = $S U(xi)$

= Neural network decoder for near-term surface-code experiments

== Synopsis
=== Problem
针对 correlated defects 问题，MWPM 解码器由于 i.i.d error model assumption，导致纠错性能下降。希望使用 neural network 实现比 MWPM 解码器更低的逻辑错误率。

=== Solution
1. Error Model: circuit-level Pauli-noise models; higher or lower probability of applying *Y* errors.
2. NN Arch: recurrent NN arch
3. Equipment
  1. Training: DelftBlue supercomputer
  2. Carried: NVIDIA Tesla V100S GPU
  3. CPU: Intel(R) Core(TM) i7-8850H CPU @ 2.60GHz

=== Achievement
1. 使用以上错误模型训练的 NN decoder 在实验数据上的测试性能($epsilon_L=3.0% "on" d=3$)超过了 MWPM 解码器($epsilon_L=4.5% "on" d=3$)，与 maximum-likelihood decoding(TN)相当。
2. 对于实际 qpu 产生的 syndromes，NN 不需要依赖对其错误概率、缺陷和纠错方法进行建模（如 TN 需将其编码为超图结构）。





=== Comment
1. 使用实验数据如何训练，如何设置 loss func 和 backpropogation？
  1. 实验数据的 output 为，在经历 n 轮纠错循环后，在最后一轮进行破坏性的测量，看结果是否发生逻辑反转，事实上做不了模拟中实现的 recurrent NN。
2. 可扩展性老生常谈，如何处理当码距增加时的训练难度指数级增加问题？
3. 声称不需要任何对 error models 的先验知识，这是伪命题。
  1. 使用模拟数据进行训练本身就需要设定 error model
  2. 使用实验数据来训练时，实际上不也是在建模 error model 吗，只不过像黑箱一样隐藏在神经网络的内部参数中了
  3. 显然使用实验数据训练得到的 NN 不能够应用在其他 qpu 上，只能专用于这一个 qpu，并且一旦其物理性质发生了一些改变，也需要重新训练、
4. 预测的本质：解码器的本质是在每一轮忠实地记录根据 syndrome 解码出来的比特可能的错误情况，并判断这些错误是否构成一个逻辑错误，并在经典计算机上实时保存当前逻辑比特状态，并不会直接对量子比特进行纠错（这反而可能引入新的错误，也极大地耗费时间降低性能），使用表面码等拓扑码就是为了不需要实时纠错不是吗。



== Tech details
=== Tools
1. stim
2. TensorFlow
3. Adam optimizer

=== setting for NN
#image("NNarch.png")
1. *Input*: $d_(a, r)$ 是模拟中的每轮 syndrome，$d_(a,N)$ 是最后纠错循环结束后对数据比特测量结果推断出的 syndrome
2. *network*: 两层 LSTM 和一个 ReLU 激活层，后面跟着评估层，有两个接收头，一个仅接受 $d_(a,r)$ 并作出对逻辑错误率的预测，一个将 $d_(a,r)$ 与 $d_(a,N)$ 整合后做出预测
3. *output*: 转换为二分类问题：“是否发生逻辑错误？”预测纠错循环结束后的逻辑错误率
4. *cost function*: $I=H(p_("main"), p_("true"))+w_a H(p_"aux", p_"true")$

== Training workflow
1. data generation:
  - error model setting
  - data format: `([d_a,r=1...N-1], [d_a,N], p_true)`
  - (soft information) 
2. model training:
  - `d_a,r=1...N-1` $->$ `recurrent_input`
  - `d_a,N` $->$ `final_input`
  - `p_true` $->$ `p_main, p_aux`

== Inference workflow
1. input: `d_a,r=1...N`
2. output: `p_main`
3. logical qubit measuring result: `M_L`
  - `p_main>0.5` $->$ `M_L ^ 1`
  - `p_main<=0.5` $->$ `M_L`

== Engineering Work
1. *Stim* generates `(defects, label)` data pair 
2. Simple neural network construction(*TensorFlow*)
3. Loss function setting(*keras*)
4. *MWPM*(pymatching) for benchmark

== Improvement
1. 本文中的 NN 仅使用模拟数据进行训练，并未使用实验数据
2. NN 的可扩展性是一个问题，本文使用的 recurrent NN 不具有可扩展性，


= Learning high-accuracy error decoding for quantum processors

== Synopsis
AlphaQubit


=== Solution
1. Error Model: richer noise model than those considered in previous machine-learning decoder work—including leakage, cross-talk and soft readouts with an amplitude damping component
2. NN Arch: recurrent-transformer-based neural-network architecture that learns to predict errors in the logical observable based on the syndrome inputs


=== Achievement
1. 优于张量网络
2. 规模增加（码距增加至 11）时精度依然维持，优于 soft-input-augmented correlated matching method.
3. 能泛化至远超训练范围的轮次
4. 本解码器的核心优势在于从真实实验数据中学习的能力。这使得它能够直接利用表征I/Q噪声和泄漏效应的丰富输入，无需为每个特征手动设计特定算法。（？）



=== Improvement
1. 码距增加到 11 后的训练难度和训练数据需求量都显著增加
2. 需要改进解码器吞吐量

== Tech details / Inference workflow 

=== NN arch
#image("AlphaQubit_nnarch1.png")
#image("AlphaQubit_nnarch2.png")

The decoder architecture is implemented and trained using the JAX, Haiku and JAXline ML frameworks.

=== Input-StablilizerEmbedder
将多模态输入转换为统一的 representation

1. 提供 1-4 个输入，传入各自的 Linear 层
  - Measurement: 稳定子测量结果 $ "post"_1="the posterior probability of observing a" ket(1) "state" $
  - Event: 即 defect，检测产生翻转的事件
  - \*Leakage: 泄漏概率 $ "post"_2="the probability of having seen leakage" $
  - \*Event leakage: temporal-difference analogue
2. 将 index $i$ 传入 Embed 层，以提供对物理布局的感知
3. 将第一步特征向量和第二步位置向量累加融合为一个稳定子的表征向量
4. 将每个表征提供给 2-layer ResNet，生成提供给 RNN 的表征 $S_(n i)$
5. 末轮需做特殊处理: As  the final-round stabilizers are not measured but computed from the data qubits, we encode this by using a separate embedding for the final round, with a separate final-round linear projection for the on-basis computed stabilizers and a single learned embedding for all the undefined off-basis stabilizers (where on- and off-basis stabilizers are defined in 'The rotated surface code').
=== RNN core(pseudo code provided)
依序列捕捉空间局域性质和长程非局域性质

1. 合并上一次解码器状态 $bold(X)_(n-1)$ 与本次稳定子表征 $bold(S)_n$
2. 循环多次输入给 SyndromeTransformer:
  1. layer_norm
  2. Multi-head Attention with bias: 捕捉长程、非局域关联，即任意稳定子间的关联，bias 告诉模型哪些稳定子对更值得关注
  3. layer_norm
  4. GatedDenseBlock: FFN
  5. ScatteringResidualConvBlock: 捕捉局部特征
    - Scatter to 2D: 将稳定子向量列表依其物理上的排列铺到 2D 网格上
    - Dilated convs
    - Gather from 2D 
3. 输出解码器状态 $bold(X)_(n)$
=== Readout
1. Scatter to 2D $->$ Conv to data: 将稳定子状态转化为 2D 网格上的数据比特状态
2. Project: 特征降维（$1 times 1$ 卷积？）
3. Line mean pool: 沿与 logical observable 垂直的行或列进行平均池化
4. Cycle embedding: 提供实验轮次信息
5. ResNet and output： 给出最终 Prob(error)


== Training workflow
1. *Pretraining*: 用 Stim 生成大量基础 memory experiment 的数据，让模型学习基本解码规则，使用 DEMs、XEB、SI1000 等不同 error model 先后训练。
2. *Finetuning*: 使用来自 Sycamore 处理器的实验数据或者 Pauli+ simulator 的数据（模拟了 leakage, cross-talk）进行调优。
3. *Loss func*: 交叉熵。随机梯度下降优化。


== TODOs
1. 数据源：Stim 生成基本数据
  1. 使用 Google 的 error model
    1. DEM: 实验拟合的 $p_(i j)$
      - twofold cross-validation: 奇数采样点在偶数索引 shots 数据集上评估，反之偶数在奇数索引上评估 
    1. XEB: 从 Stim 模拟电路生成的 detector error model
  2. SI1000: As measurements remain a major source of errors in superconductors, measurement noise has weight 5p for noise parameter p. In contrast, single qubit gates and idling introduce only a small amount of noise, hence their relative strength is p/10. #figure(image("SI1000.png", width: 40%)) ```py
   stim.Circuit.generated(
        code_task="surface_code:rotated_memory_z",
        rounds=r,
        distance=d,
        after_clifford_depolarization=p/10,
        after_reset_flip_probability=2*p,
        before_measure_flip_probability=5*p,
        before_round_data_depolarization=p,
    )
  ```
  3. 一个 `.npz` 文件为一个错误模型生成的 `numpy` 数据集，包含从 1 到 25 共 13 个 round 的检测事件数据，每种 round 都采样 $N$ 次。
  4. \* 目前仅有 Z 基模拟实验数据，还需加上 X 基模拟数据。
  5. \* 之后尝试增加 "noise curriculum" 即输入数据错误率由弱渐强的数据集排布方式，以提高训练稳定性（略微提高正确率）。 
2. 输入：
  1. 数据结构考量
  2. 输入方式（一并输入还是跑一个 round 输入一次）
  3. index 
3. 神经网络构建
  1. Embedder 
  2. RNN core
  3. Readout
4. Output 与 Loss function


== Questions
1. Soft measurement inputs v.s. soft event inputs
2. 散射分步到 2D 网格上如何处理？
  1. 依照 DEM 上 detector 的坐标排布
  2. 但是一轮 Z 基实验，X 型稳定子测量两次，是否会覆盖？
3. attention bias 如何处理
4. 简化：先仅仅使用长度（轮数）为 25 的数据作为输入，以方便数据集的处理
5. on- and off- basis stabilizers: different weights.
6. JAX arch?
7. 单从数据量上来看，d=3 到 d=11 的数据量也就翻 15 倍
8. Mamba decoder?
  1. 将 self-attention($O(d^4)$) 改为 Selective SSM($O(d^2)$)
  2. 没有改善高码距下错误样本稀缺，训练数据量量和算力需求过大等问题
  3. 百微秒量级（4090 硬件模拟）
  4. 如何做到变长输入？



