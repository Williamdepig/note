#import "@local/mathnote:0.1.0": *
#import "@preview/ilm:1.4.1": *
#import "@preview/physica:0.9.6": *
#import "@preview/algorithmic:1.0.7"
#import algorithmic: style-algorithm, algorithm-figure
#show: style-algorithm

#show: ilm.with(
  title: [Machine learning message-passing for the scalable decoding of QLDPC codes],
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
  // table-index: (enabled: true),
  // listing-index: (enabled: true),
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

= Synopsis
== Problem
BP does not have a threshold for the surface code and fails to decode most of the time, leading to the necesity of a second stage decoder(OSD), which increases the decoding runtime. Need to find a (machine learning) method that can successfully decode QLPDC codes in a single stage.




== Solution
*Astra*: The decoder is based on graph neural networks (GNN) which learn a message-passing algorithm(BP) for decoding.
3
- Traditional neural network decoder: _the entire syndrome_ $->$ _the entire error mode_ $->$ _logical error happened_
- Astra: _local function_ $->$ _message passing algorithm_ $->$ _solving sudoku problem and predict node state_ $->$ _logical error happened_

== Achievement

1. works on any family of codes that can be represented by Tanner graphs;
2. is capable of transfer learning(scalable);
3. has faster runtimes compared to BP + OSD while improving on accuracy.
4. higher PER threshold, lower LER

= Principle
*Core logic*: The degree of the nodes does not change with increasing QECC distance. Once learnt, the functions can be reused for interpolated and extrapolated decoding, as well as extrapolated training.

== Local functions
1. $f$: how to send messages between nodes. multi-layer perceptron(*MLP*).$"MLP"_1$ for sending message.
2. $g$: how to combine the messages and update the node status. Another NN, a gated-recurrent unit (*GRU*) to learn the $g$ function.
3. $r$: how to compute the final outputs from the node states.$"MLP"_2$ for output.

== Tanner graph
#figure(image("tanner.png", width: 100%))

== Training
=== Loss function
To overcome the challenges of training in the presence of degeneracy, it uses a loss function which consists of two parts:
1. Cross entropy loss
2. NBP Loss: $ H^T e_"total"&=0 "mod" 2 \ e_"total"&=(e_"actual"+e_"predicted")%2 $

=== Extrapolated Training
We tested extrapolation training for $d_9$, in multiple trials with exactly the same hyperparameters training $d_9$ from scratch took $>90$ epochs whereas training $d_9$ from $d_7$ took on average 30 epochs to achieve the best LER.
== Defects
1. How to implement multi-rounds continuous decoding for circuit-level error model?
2. Sub-optimality of Extrapolation: $d$ $->$ at most $(d-1)/2$ errors
3. Single scheduling strategy: flooding.
  - serial scheduling better? 



= Relay-BP
== Problem
*qLDPC decoder standard*:
1. _Flexible_: Decodes a wide range of qLDPC circuits. 
2. _Accurate_: Has the ability to achieve the low logical error rates required by logical computations. 
3. _Compact_: Has a small footprint on an FPGA. 
4. _Fast_: Avoids the backlog problem by processing syndromes at their production rate.

#figure(image("table.png", width: 80%))

== Solution
- *Mem-BP*: dampen oscillations in BP
- *DMem-BP*(disordered memory strength distributions): improve convergence
- *Relay ensembling technique*: successive DMem-BP runs are initialized with the previous run's final marginals
- *Negative memory strengths*: escape from trapping sets


== Technique details

#figure(image("relayBP.png", width:80%))

=== DMem-BP
In tanner graph, denote messages between check node $i$ and error node $j$ as $mu_(i->j)$ and $nu_(j->i)$, each passing a local log-likelihood belief of whether an error $j$ occurred (negative) or not (positive).: 
$ mu_(i->j)(t) = kappa_(i,j)(t)(-1)^(sigma_i) limits("min")_(j'in cal(N)(i)\\{j}) abs(nu_(j'->i)(t-1)), $
where $k_(i,j)(t)="sgn"{limits(product)_(j'in cal(N)(i)\\{j}) nu_(j'->i)(t-1)}$ and $cal(N)(j)$ means the neighbors of node $j$.
$ nu_(j->i)(t)=Lambda_j (t)+sum_(i'in cal(N)(j)\\{i}) mu_(i'->j)(t) $

#note-box[
  _Product-Sum_: $ mu_(i->j)(t) = 2 tanh^(-1)((-1)^(sigma_i)product_(j'in cal(N)(i)\\{j}) tanh((nu_(j'->i)(t-1))/2)) $
]

For error nodes, we have another value named marginal,defined as:
$ M_j (t)=Lambda_j (t)+sum_(i'in cal(N)(j))mu_(i'->j)(t) $
and the bias $Lambda_j (t)$ can be updated via the equation:
$ Lambda_j (t)=(1-gamma_j)Lambda_j (0)+gamma_j M_j (t-1). $

_Parameter initialization and stopping:_ 

- $ Lambda_j (0)=nu_(j->i)(0)=log((1-p_j)/p_j)$.
- $M_j (0) = M_j$ is set by user input.
- $Gamma={gamma_j}_(j in [N])$ is memory strength parameter set. The special cases of all $gamma_j$ values either zero or a constant between zero and one recover the standard BP and Mem-BP algorithms.
- $hat(e)_j (t)="HD"(M_j (t)), "for HD"(x) = 1/2 (1-"sgn"(x))$, denotes the hard decision of error node. If $bold(H hat(e))(t)=bold(sigma)$, the algorithm is considered to have converged. Otherwise we move on until the max iteralions $t=T$.
- $w(bold(hat(e)))=sum_j hat(e)_j log((1-p_j)/p_j)$, solution weight.

=== Relay-BP-$S$
- number of solution sought $S$,
- maximum number of relay legs $R$, 
- maximum number of iterations for each leg $T_r$,
- memory strengths for each leg $bold(Gamma_r)={gamma_j (r)}_(j in [N])$.

*Core:* 
- The $r^("th")$ leg's marginals are initialized with the $(r-1)^("th")$ legs final marginals. 
- Each leg stops upon finding a solution or reaching the iteration limit $T_r$.
- The algorithm stops when $R$ legs have executed or $S$ solutions have been found.
- Return the lowest-weight solution: $w(bold(hat(e)))=sum_j hat(e)_j log((1-p_j)/p_j)$.

#algorithm-figure(
  [Relay-BP-$S$ decoder for quantum LDPC codes],
  inset: 0.25em,
  vstroke: .5pt + luma(200),
  {
    import algorithmic: *
    let Cmt(c) = text(fill: gray)[\/\/ #c]

    // 自定义带侧边注释的代码行
    let LC(code, c) = Line(code + h(3em) + Cmt(c))

    Procedure([Relay-BP-$S$], ([$bold(H)$, $bold(sigma)$, $bold(p)$, $S$, $R$, $T_r$, $bold(Gamma_r)$]),
    {  
      Assign([$lambda_j, M_j (0)$], [$log (1-p_j)/p_j, r <- 0, s <- 0, hat(bold(e)) <- nothing, omega_(hat(bold(e))) <- infinity$])
      
      // Line 2: Outer Loop
      For($r <= R$, {
        // Line 3: Comment
        Line(Cmt("Run DMem-BP"))
        
        // Line 4: Double Assignment
        // 利用 Assign 的第二个参数可以包含 "<-" 来模拟连等
        Assign([$Lambda_j (0)$], [$nu_(j->i)(0) <- lambda_j$]) 
        
        // Line 5: Inner Loop
        For($t <= T_r$, {
          // Line 6
          Assign($Lambda_j (t)$, $(1-gamma_j (r)) Lambda_j (0) + gamma_j (r) M_j (t-1)$)
          
          // Line 7-9: Computations with side comments
          LC([Compute $mu_(i->j)(t)$], "via Eq. (1)")
          LC([Compute $nu_(j->i)(t)$], "via Eq. (2)")
          LC([Compute $M_j (t)$], "via Eq. (3)")
          
          // Line 10
          Assign($hat(e)_j (t)$, [HD($M_j (t)$)])
          
          // Line 11: Convergence Check
          If($bold(H) hat(bold(e))(t) = bold(sigma)$, {
            // Line 12
            Line(Cmt("BP converged"))
            
            // Line 13
            Assign($omega_r$, $w(hat(bold(e))) = sum_j hat(e)_j lambda_j$)
            
            // Line 14
            Assign($s$, $s+1$)
            
            // Line 15: Better solution check
            If($omega_r < omega_(hat(bold(e)))$, {
              Assign($hat(bold(e))$, $hat(bold(e))(t)$)
              Assign($omega_(hat(bold(e)))$, $omega_r$)
            })
            
            // Line 19: Break
            LC([*break*;], "Continue to next leg")
          })
          
          // Line 21
          Assign($t$, $t+1$)
        })
        
        // Line 23: Enough solutions check
        If($s = S$, {
          LC([*break*;], "Found enough solutions")
        })
        
        // Line 26
        Line(Cmt("Reuse final marginals for the next leg"))
        
        // Line 27-28
        Assign($M_j (0)$, $M_j (t)$)
        Assign($r$, $r+1$)
      })
      
      // Line 30: Return
      Return($(s>0), hat(bold(e))$ + ";")
    })
  }
)


= Improved GNN?
== 以 Relay-BP 为主体
- 考虑改善 Memory selection 机制，用 NN 代替随机选择
- 比如:
  1. Input: $bold(sigma) + M_j (t)$
  2. Structure: GNN
  3. Output: $bold(Gamma_r)={gamma_j}$
  4. loss: $H^T (e_"actual"+e_"total")$
- 预期: 虽然增加了用 NN 选择 memory strength 的过程，但是预测能大幅减少 Relay-BP 找到正确解所需的 Relay 次数

$ "Input"limits(-->)^"NN" Gamma_r limits(-->)^"BP" M_j limits(-->)^"HD" e_"predicted" $

=== TODO
- 数据布局——物理布局对应
- 搞懂 dem 里的 dectector 布局
- 尝试在 gpu 中，同向数据传输
  - 做不到相邻节点同向传输，可以做到合并访存
- 尝试 trap set 对于 relay 的影响
- 随着码距增加，解不出解的样本分布性质
- 也和 Relay-BP 的 rust 实现做点比较呗


== 以 Astra 为主体
- 消息传递过程，CN 固定使用 Min-Sum 规则(XOR)，而 VN 则保留使用 MLP 来学习
- 保留使用 GRU 来更新节点本轮状态 $h_t$，而非引入 Memory 机制 
- 考虑混合架构，并引入 Relay 机制？如果没有 Memory，引入 relay 没有意义，相当于增加 BP 的 iteration 次数


= Experiment
== Relay-BP
=== Time consuming:
  1. _Total Iterations_: 1142
  2. _Mem Update_:    0.00353646s (2.24491%)
  3. _Check Update_:  0.0630064s (39.9959%)
    1. _Find Min Nu_: 59.09175%
    2. _Update Mu_:   40.90825%
  4. _Var Update_:    0.0638354s (40.5221%)
    1. _Sum Mu_:      52.91366%
    2. _Update Nu_:   47.08634%
  5. _Syndrome Check_:0.0271539s (17.237%)

=== Detector Error Model

1. Detector matrix: $D$
2. Measurement syndrome matrix: $Omega$
3. Detector error matrix: $H=D Omega$

=== Difficulties and Problem
1. *DEM*: 物理层与算法层的接口，屏蔽了错误类型与发生时间，保留了症候(触发哪些 detector)和概率(合并了会导致相同症候的错误的概率)。
2. *Trapping Sets*: 依然无法确定是否确实是一个问题，可能是调参问题？？？
3. *比较 Relay-BP 的 rust 实现*: relay 次数和 gamma 分布采样是关键参数。
  - d=11 的情况下，对于较复杂的情况，最大需要 200 次 relay 才最终找到合理解
  - 并没有加上 syndrome check skip
  - 如果仅使用 100 次 relay，错误率不均匀(5% 到 20%)，与数据样本分布关系大
  - rust 里加入了 
4. *GPU 部署的内存分布问题*: 在一个 warp 中存储
  - _同一个 shot 下的不同 node_ *v.s.* _不同 shots 下的同编号 node_
5. 下一步优化方向：
  - 在 GPU 实现中，Product-Sum 是否比 Min-Sum 更精确，也不损失什么性能？
  - 调参问题
  - GPU 加速，主要是 Syndrome Check Skip 
  - *优化减少 Leg 次数*
6. 在高码距(d=17)，较高错误率(p=0.003)的情况下，相较于 pymatching、Relay-BP-CudaQ 的实现，解码速率和准确度都大幅下降，不知是代码实现上有什么细节问题，还是参数方面有问题(leg=300, S=9, iter=60, iter 数不足？)。
7. 尝试跑一下高码距下的阈值

== Relay-BP Algorithm Optimization


= Real-Time Decoding
== Mamba Decoder
#figure(image("./Mamba.png"))
1. 将 AlphaQubit 的 self-attention($O(d^4)$) 改为 Selective SSM($O(d^2)$)
2. 没有改善高码距下错误样本稀缺，训练数据量量和算力需求过大等问题
3. 百微秒量级（RTX4090 硬件模拟）
4. 将 Physical error rate Threshold 从 0.0097(AlphaQubit) 提升至 0.0104(Mamba)

