#import "@local/mathnote:0.1.0": *
#import "@preview/ilm:1.4.1": *
#import "@preview/physica:0.9.6": *

#show: ilm.with(
  title: [Algorithms & Applications Team, Quantum-Leaped Computing MTS --- Interview],
  author: "Williamdepig",
  // date: datetime(year: 2025, month: 08, day: 08),
  date: datetime.today(),
  abstract: [
    // Note by Williamdepig
  ],
  // preface: [
  //   #align(center + horizon)[
  //     Thank you for using this template #emoji.heart,\ I hope you like it #emoji.face.smile
  //   ]
  // ],
  // bibliography: bibliography("refs.bib", style: "ieee"),
  figure-index: (enabled: true),
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


= Fundamental Concept
== Qubits and Quantum state
1. 如何表示一个 qubit：$ket(phi)=a ket(0)+b ket(1).$ 我们从线性代数的视角出发来理解量子力学（或者说从实验现象构建出这种数学模型，成为了量子力学的基本描述工具），一个孤立物理系统是一个态空间（state space），可以完全由态矢量（state vector）描述。我们取一个二维系统，定义该系统的单位正交基为 $ket(0),ket(1)$。该系统即是一个 qubit，其态矢量就可以用 $ket(phi)=a ket(0) + b ket(1)$ 来描述。然后就是狄拉克符号的描述优势和线性代数的一系列性质。
  1. Bloch 球表示任意量子态（基态和叠加态）。
  2. 测量对应的算符（可观测物理量）的本征值和本征态。
  3. 通过张量积组合多比特系统（直积态和纠缠态），以及系统的密度矩阵描述（纯态和混合态，系统的迹）。
  4. 哈密顿量与时间演化。
2. 量子线路是对应于图灵机的一种量子系统的计算模型。
  1. 基本单比特门：Pauli-X,Y,Z, Hadamard, T, S
  2. 双比特门：核心是 CNOT 门
  3. 通用量子计算
3. 关键物理概念：叠加、干涉、纠缠、退相干


== Quantum Algorithms
1. 经典理想算法
  1. Deutsch-Jozsa Algorithm: 量子优势的首次体现
  2. Grover Search Algorithm: $O(sqrt(N))$ 优化加速搜索和任何需要暴力搜索的优化问题
  3. Shor Factoring Algorithm: 模指数运算 $arrow$ 量子傅里叶变换 $arrow$ 经典后处理。QFT 如何提取周期信息？
2. NISQ 时代的算法：变分量子算法、量子机器学习
3. 如何将具体问题编码到量子计算机上？如何写出某个系统的哈密顿量？


== 实际量子硬件与纠错
1. 主流量子比特实现（大致优缺点，相干时间、门速度、连接性）：
  1. 超导：
  2. 离子阱：
  3. 光量子：
  4. 拓扑量子：
2. 纠错：
  1. 各种编码方式
    1. 3-repetition code
    2. shor code
    3. stabilizer code
  2. 表面码
    1. 数学原理
    2. 表面码解码，考虑多种解码器
  3. 噪声模型
3. 编程语言与框架，我所使用的是 qutip 库


= 该团队主攻方向
1. 利用量子计算（特别是经典量子混合计算）来加速和增强人工智能等应用，并实现产业化落地。
2. 考虑 VQA

== 疑问
1. 我对你们团队“量子跃迁计算”感到很有意思。“跃迁”通常对应 transition，但是你们所用的是 Leap，它的具体体现在哪？
2. 曾提过这个 FPGA decoder 项目，我想问主要是为了解决量子纠错中的实时解码问题，还是为了加速混合算法中经典优化器的某些特定计算模块？
3. 交付体现在？
  1. 是致力于打造一个通用的经典-量子混合计算平台，以完成不同行业的多种问题？还是更侧重于针对特定领域？
  2. 目前算法团队主要瞄准的是概念验证级别的小规模问题，还是已经可以处理接近工业级应用规模的真实数据？
  3. 最终“交付”的产物，更偏向于一个集成化的软硬件一体机，为客户提供超算能力；还是一个云服务 API，允许用户远程提交计算任务？

== 我的优势区间
1. 线性代数和量子计算基础
2. 了解经典量子算法
3. 量子纠错理论和简单实践（stim 电路模拟）
4. FPGA 编程基础
5. 学习能力强（一周前端实战多平台 google 插件）

== 我的项目经验
1. 从零构建一个以冯诺依曼架构为基础的现代流水线 cpu 并在其上堆料，类似一生一芯计划。
2. 纠错理论研究，简单使用 stim 进行了逻辑错误率的评估和拟合（MWPM 算法）