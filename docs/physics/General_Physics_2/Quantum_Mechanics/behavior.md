---
counter: True
comment: True
---

# 量子行为

!!! info 简介
    我们将先把基本的量子概念向各位作出阐述，逐步推导出薛定谔方程与哈密顿算符，再介绍其实际物理意义。

## 量子力学第一原理

### 原理内容

1. 理想实验中，某个事件的发生概率由一个复数 $\varphi$ 给出，$\varphi$ 被称为概率幅(Probability Amplitudes)。

$$
\begin{aligned}
P &= \mathrm{probability}\\
\varphi &= \mathrm{probability\ amplitude}\\
P &= |\varphi|^2
\end{aligned}
$$

2. 当事件可以以多种方式发生(事实上就是系统有多种可能的状态)，会发生干涉，概率幅叠加。

$$
\begin{aligned}
\varphi &= \varphi_1+\varphi_2\\
P &= |\varphi_1+\varphi_2|^2
\end{aligned}
$$

3. 但如果在实验过程中对事件发生了**观测(observation)**，以至于能够确定事件以什么方式发生，那么干涉就会消失，事件整体的发生概率就会变成简单的相加。

$$
P=P_1+P_2=|\varphi_1|^2+|\varphi_2|^2
$$

### 电子的理想干涉实验

我们可以通过“电子的理想干涉实验”来简单地认识这个原理。
![电子干涉](/assets/images/physics/General_Physics_2/Quantum_Mechanics/electron_interference.png)
装置由电子枪、双缝、后障和接收器组成。实验的结果与推论如下：

- 接收器接收到每个电子时，获得的信号强度是相同的，**结论**：电子总以“粒子”的形式到达。
- 遮住缝 2 或者缝 1，接收器在后障上探测到的强度分布如 $P_1$ 或 $P_2$ 所示，其表征了电子到达后障的概率分布。同时打开缝 1 和缝 2，接收器在后障上探测到的强度分布如 $P_{12}$ 所示，显然，$P_{12} \neq P_1 + P_2$，这表明电子在穿过双缝时发生了干涉。这难以用常识或者经典物理学解释，电子的运动很“神秘”。**结论**：电子并不是要么通过缝 1 要么通过缝 2，即当事件可以以多种方式发生时，我们不能断言过程中事件会以**某个**方式发生。
- 但是在数学上解释这个现象是却相当容易，我们可以用复数 $\varphi$ 来描述电子的概率幅，即缝 1 开放时电子的概率幅为 $\varphi_1$，缝 2 开放的概率幅为 $\varphi_2$，那么电子通过双缝的概率幅为 $\varphi_{12} = \varphi_1 + \varphi_2$，电子通过双缝的概率为 $P_{12} = |\varphi_{12}|^2$，这就是干涉现象的数学描述。**结论**：电子到达后障的概率分布就如同“波”的分布一样。

这就是电子的**波粒二象性(wave-particle duality)**。

### 观测电子

![观测电子](/assets/images/physics/General_Physics_2/Quantum_Mechanics/watch_electron.png)

在上述装置的基础上，如果在缝后增添了一个光源，当电子穿过双缝时，其会散射光源发出的光，使我们可以观测到电子穿过了哪个缝。实验结果如图 c 所示，干涉消失，概率分布变为简单的相加。还有一件“神秘”的事情，当光源的波长足够大，以至于达到分辨极限(瑞利判据)，无法区分电子穿过了哪个缝时，干涉现象又会出现。

- **结论**：要设计一种装置，既确定电子穿过哪条缝，又不破坏电子的干涉图样，这是不可能的。

这就是**不确定性原理**在这个理想实验中的显现。量子力学的**全部**都基于不确定性原理的正确性。

因此对于一个量子系统，我们必须用一种特殊的方式来描述其状态：只有观测了该系统，我们才能确定其状态；否则，我们不应当去说该系统可能处于某种状态，事实上我们有一个特殊的名词来描述——此时系统处于**叠加态**。“薛定谔的猫”实验想阐述的也就是这个意思。

## 不确定性原理(Uncertainty Principle)

!!! abstract
    本章将给出数学角度的不确定性原理，并具体阐述量子力学中的波动观点与粒子观点。

    不确定原理的粒子观点 $\rightarrow$ 将粒子用波来描述，不确定原理就有数学上的解释(傅里叶变换) $\rightarrow$ 不能说这种解释是很精确的，但是能给出一些相对直观的定性描述。

### 位置与动量的测量与预测

![衍射](/assets/images/physics/General_Physics_2/Quantum_Mechanics/diffraction.png)
考虑这样一个粒子的单缝衍射实验。假设水平为 $x$ 轴，垂直为 $y$ 轴，考虑水平入射狭缝的粒子。

在入射狭缝之前，粒子只有水平方向的动量，垂直分量为零。一旦穿过狭缝，粒子的垂直位置—— $y$ 坐标数值，就被确定到缝宽 $B$ 的量级。但是，此时我们就失去了粒子垂直动量的信息，因为依照波动观点，粒子在接收屏上的概率辐会依衍射分布，也即粒子出现了垂直动量上的不确定量。

接下来做半定量的解释：

- $\Delta\theta$ 是从中央主极大到第一极小的半张角，则垂直动量的弥散程度的量级就为 $\Delta p_y = p_{x0}\Delta\theta$.
- 依照衍射的分布，$\Delta\theta=\lambda/B$.
- 垂直位置的不确定量为 $\Delta y = \frac{1}{2}B$.
- 依照物质波的观点，动量与波长的关系为 $p=h/\lambda$.

因此发现，两个不确定量的乘积 $\Delta y \cdot \Delta p_y$ 就为普朗克常量 $h$ 的量级。事实上如果再做更精确一些的计算就能得到**不确定关系**的不等式：$$ \Delta y \cdot \Delta p_y\ge \frac{\hbar}{2}. $$
其当然对其他位置坐标成立。

??? 一些谬误思想
    你可能会认为在到达狭缝的那一刻，我们既知道了粒子的动量，也知道了它的位置，动量与位置都足够精确。但这件事实际上没有意义，不确定关系是用来**预估未来的状态**的，在这个实验中就是粒子穿过狭缝之后的垂直动量——这是我们失去了的信息。至于已确定粒子穿过狭缝之前的运动和到达狭缝时的位置，这件事已经属于过去，只是一种“事后的测量”，并不是不确定性原理涉及的范畴。

### 波动观点与粒子观点

如果我们用概率幅来表征粒子，也依然可以从数学上表征不确定关系，其是自洽的。

考虑一种简单情况，振幅在空间的分布为 $e^{\textrm{i}(\omega t-\boldsymbol{k \cdot r})}$。首先有粒子能量与概率幅频率、动量与波数之间的关系：

$$
\begin{aligned}
  E&=\hbar\omega\\
  \boldsymbol{p}&=\hbar\boldsymbol{k}.
\end{aligned}
$$

- 如果波列为无限长，即我们在任何位置找到粒子的概率相等——粒子位置的不确定性无穷大，则傅里叶变换之后，该波的频谱是一个 $\delta$ 函数，波的频率确定，波数确定，也就是说粒子动量的不确定性趋于零。
- 如果波列有限长，则波列的长度 $L$ 就表征了粒子位置的不确定性 $\Delta x$。再对波列做傅里叶变换就可以得到波的频谱宽度，其可以表征波长的不确定性，略加推导就可以得到粒子动量的不确定性。
$$ \frac{1}{L} = \frac{\Delta\lambda}{\lambda^2} = \Delta\left(\frac{1}{\lambda}\right) = \frac{\Delta k}{2\pi}. $$
由于 $L\sim\Delta x$、$\Delta \boldsymbol{k}\sim\Delta\boldsymbol{p}$，因此可以发现从波函数的性质也能半定量地推导出 $\Delta x\cdot\Delta p$ 是 $\hbar$ 的量级，正对应粒子的不确定关系。

### 简单应用不确定关系求原子半径

我们曾经学过经典的玻尔的氢原子模型，其应用了角动量量子化的条件；现在我们可以用不确定关系来做相似的推导，以得到氢原子基态能量 $E=-13.60\ \mathrm{eV}$ 和氢原子经典半径 $a_0=0.528\ \mathrm{\AA}$。

假定电子运动半径的量级大致为 $a$ (显然不可能精准获得电子半径)，则电子动量的弥散范围即为 $\hbar/a$，则电子动量的量级也大致就为 $\hbar/a$。因此就有氢原子系统总能量:
$$ E=\frac{p^2}{2m}-\frac{e^2}{4\pi\varepsilon_0 a}=\frac{\hbar^2}{2ma^2}-\frac{e^2}{4\pi\varepsilon_0 a}. $$

在稳定状态下，能量趋于最小，这样的物理直觉依然是类似的。$$ \frac{\mathrm{d}E}{\mathrm{d}a}=0. $$
即可推出氢原子半径，也就是所谓的**玻尔半径(Bohr radius)** $$ a=\frac{4\pi\varepsilon_0\hbar^2}{me^2}=0.528\times 10^{-10}=0.528\\ \mathrm{\AA}. $$
代入能量可得氢原子基态能量 $$ \varepsilon_0=-\frac{me^4}{32\pi^2\varepsilon_0^2\hbar^2}=-13.60\\ \mathrm{eV}. $$

## 量子力学的数学基础

!!! abstract
    本章中我们将逐步引入量子力学中的数学，大致介绍那些抽象的数学符号，用以方便定量讨论量子问题。

### 概率幅的数学符号

![电子干涉](/assets/images/physics/General_Physics_2/Quantum_Mechanics/electron_interference.png)
对于从电子枪 $s$ 出发，到达后障上 $x$ 处的电子，我们用这种符号表示其概率幅。 $$ \varphi=\langle x | s \rangle. $$
其中竖线右边的表达式表示初始状态，左边表示终末状态。至于其实际的数学内涵，我们会在下一节讨论，目前暂且先使用物理内涵来理解这种符号。

接下来介绍两条原理：

- **第二普适原理：**
  粒子通过两种可能路径到达某一给定状态，则总振幅为各自独立的振幅之和。$$ \langle x | s \rangle_{total} = \langle x | s \rangle_{slit_1}+\langle x | s \rangle_{slit_2}. $$
- **第三普适原理：**
  粒子通过特定路径的概率幅可以分解为走过每部分路径的概率幅之积。$$ \langle x | s \rangle_{slit_1}=\langle x | 1 \rangle\langle 1 | s \rangle. $$

因此从 $s$ 到 $x$ 的振幅就可以写成 $$ \langle x | s \rangle= \langle x | 1 \rangle\langle 1 | s \rangle + \langle x | 2 \rangle\langle 2 | s \rangle. $$

此外，还有一条**附加原理**：

- 两个不存在相互作用的粒子各自达到某一状态的概率幅为各自概率幅之积。 $$ \varphi=\langle a | s_1 \rangle\langle b | s_2 \rangle. $$

由于这些叠加性质，我们只要知道粒子在双缝处的概率幅 $\langle 1 | s \rangle$ 与 $\langle 2 | s \rangle$，就足以推出在后障上的概率幅分布，也就能做到“预测”未来，而不需去考虑到达双缝前的粒子状态。

### 自旋(spin)

!!! abstract
    本章我们要阐述量子力学中一个非常反直觉非常困难的概念——自旋。为了不产生额外的困惑，我们并不用经典力学来做任何对应，而单进行纯粹的量子力学讨论。不过事实上我们也并不准备细讲自旋，而是通过自旋引入真正重要的东西——态矢量。

自旋是粒子的一个内禀性质(类似质量、电荷量等等)，其取值是量子化的，通过归一化和定义，可以使之取值为整数或半整数。我们仅仅关心可观测量(observable)，不去考虑粒子自旋的物理上的什么更内在的解释。以下通过一个实验来初窥自旋。

#### 施特恩-格拉赫(Stern-Gerlach)装置

![basic apparatus](/assets/images/physics/General_Physics_2/Quantum_Mechanics/basic_stern.png)

基础装置如图，一束准直射束通过非均匀磁场，磁场和磁场变化梯度均沿 z 向，则对于某类原子，射束会沿 z 向分裂为三束。这类原子被称为**自旋 1(spin one)** 粒子，其自旋取值为 $+1,0,-1$。

通过该装置会产生三束“纯化”的射束，每束当中的粒子会处于某个**确定状态**，意思就是如果将其中一束送入第二台完全一致的装置，其不会发生分裂，且偏转方向依然同前一台一样。

![modified apparatus](/assets/images/physics/General_Physics_2/Quantum_Mechanics/modified_stern.png)

这是改进后的装置，通过设置磁场使得射束先分裂后汇聚。需要说明的是，这种对基础施特恩-格拉赫装置的改装只是一种设想，仅仅为了方便接下来的讨论。我们会通过后面讲述的量子行为来预测其正确性，当然这是建立在其它类似的实际存在的实验基础之上。

![symbols](/assets/images/physics/General_Physics_2/Quantum_Mechanics/symbols.png)

姑且使用这样的符号表示该装置，竖线表示挡住哪束粒子。这是费曼先生自创的符号，并不是量子力学的专用符号。

接下来考虑两个装置的组合，在以下几种情形中，分析粒子透过第二台装置的比率。

$$
\left\{\begin{aligned}
&+ \\
&0&\boldsymbol{|}\\
&-&\boldsymbol{|}
\end{aligned}\right\}
\left\{\begin{aligned}
&+ \\
&0&\boldsymbol{|}\\
&-&\boldsymbol{|}
\end{aligned}\right\}.
$$

1. 所有穿过第一台装置的粒子，都能穿过第二台。

$$
\left\{\begin{aligned}
&+ \\
&0&\boldsymbol{|}\\
&-&\boldsymbol{|}
\end{aligned}\right\}
\left\{\begin{aligned}
&+&\boldsymbol{|}\\
&0\\
&-&\boldsymbol{|}
\end{aligned}\right\}.
$$

2. 所有穿过第一台装置的粒子，都不能穿过第二台。

$$
\left\{\begin{aligned}
&+&\boldsymbol{|} \\
&0\\
&-&\boldsymbol{|}
\end{aligned}\right\}
\left\{\begin{aligned}
&+&\boldsymbol{|} \\
&0\\
&-&\boldsymbol{|}
\end{aligned}\right\}.
$$

3. 所有穿过第一台装置的粒子，都能穿过第二台。其余情况都可以类推得到。

接下来使用量子力学来描述。如果原子分别通过了一台如先前符号表中 (b)、(c)、(d) 图所示的装置，则说通过后的粒子处于$+S 、0S 、-S$ 态。根据以上两台装置组合实验的结果，可以知道通过粒子的概率幅：

1. $\braket{+S | +S} = 1$
2. $\braket{0S| +S} = 0$
3. $\braket{0S|\enspace0S} = 1$
4. ......

以上实验结果可以由一个三阶方阵表示：

$$
\begin{pmatrix}
1 & 0 & 0 \\
0 & 1 & 0 \\
0 & 0 & 1 \\
\end{pmatrix}.
$$

我们发现，+S、0S、-S 三态似乎有一种两两“正交”的关系。

#### 过滤粒子

![tilted](/assets/images/physics/General_Physics_2/Quantum_Mechanics/modified_stern_tilted.png)

接下来考虑两台并不完全一致的装置的组合。T 装置相对于 S 装置在 y 轴上存在偏转。重新考虑前述矩阵。

答案是，此时 $\braket{+T | +S}\neq 1$ 并且 $\braket{-T | +S} \neq 0$ 等等，则矩阵应写为：

$$
\begin{pmatrix}
\braket{+T | +S} & \braket{+T | 0S} & \braket{+T | -S}\\
\braket{0T | +S} & \braket{0T | 0S} & \braket{0T | -S}\\
\braket{-T | +S} & \braket{-T | 0S} & \braket{-T | -S}
\end{pmatrix}.
$$

也就是说，从 S 出射的粒子相对于 S 是纯化的，即处于一个定态，但相对于 T 的状态并不确定，需要重新取向。

如果要求粒子进入某一态的概率，由于取值为复数，即为求概率幅与其共轭的乘积，比如求 $+S$ 态粒子进入 $+T$ 态的概率 $$ |\braket{+T | +S}|^2=\braket{+T | +S}\braket{+T | +S}^*. $$

由于凡是进入 T 装置的粒子，它只能在 T 的 3 个状态之一被发现，因此有

$$
\begin{aligned}
&\braket{+T | +S}\braket{+T | +S}^* + \braket{0T | +S}\braket{0T | +S}^*\\
&+\braket{-T | +S}\braket{-T | +S}^* = 1.
\end{aligned}
$$

接下来有一个有关粒子“记忆性”的问题，考虑下面的装置

$$
\left\{\begin{aligned}
&+ \\
&0&\boldsymbol{|}\\
&-&\boldsymbol{|}
\end{aligned}\right\}_S
\left\{\begin{aligned}
&+ \\
&0&\boldsymbol{|}\\
&-&\boldsymbol{|}
\end{aligned}\right\}_T
\left\{\begin{aligned}
&+&\boldsymbol{|} \\
&0\\
&-&\boldsymbol{|}
\end{aligned}\right\}_{S'}.
$$

粒子通过一个 +S 装置和一个 +T 装置后，再通过一个 0S 装置(为作区别，在图中用 S' 表示)，会有粒子出射吗？

答案是会的，粒子通过 +T 装置后成为一束纯化射线，之后的行为与先前无关，使用概率幅能很好地理解，
$$ \varphi=\braket{0S | +T}\braket{+T | +S}. $$
显然这并不为零，通过 T 的粒子会重新取向，而粒子在进入 T 装置前的状态只决定从 T 装置出射粒子的数目，不影响出射粒子的状态与行为。

#### 基础态(base state)

从以上现象中可以归纳出：

- 当过滤器性质优良，即能保证过滤后粒子的“纯粹性”(满足先前的单位矩阵)，则通过过滤，原子体系会被分解到一组**基础态**。
- 处于某一基础态的粒子，其未来的行为由该基础态决定，而不依赖于过去的状态。
- 基础态取决于过滤器。比如 $+T、0T、-T$ 与 $+S、0S、-S$ 各是一组基础态。

另外一个事实揭示了基础态的真正重要的性质。考虑以下两组装置

$$
\left\{\begin{aligned}
&+ \\
&0&\boldsymbol{|}\\
&-&\boldsymbol{|}
\end{aligned}\right\}_S
\left\{\begin{aligned}
&+ \\
&0\\
&-
\end{aligned}\right\}_T
\left\{\begin{aligned}
&+&\boldsymbol{|} \\
&0\\
&-&\boldsymbol{|}
\end{aligned}\right\}_{S'}
\\[3mm]
\left\{\begin{aligned}
&+ \\
&0&\boldsymbol{|}\\
&-&\boldsymbol{|}
\end{aligned}\right\}_S
\left\{\begin{aligned}
&+ \\
&0\\
&-
\end{aligned}\right\}_T
\left\{\begin{aligned}
&+ \\
&0&\boldsymbol{|}\\
&-&\boldsymbol{|}
\end{aligned}\right\}_{S'}.
$$

对于敞开的 T 装置，S' 中粒子出射比例为多少？事实就是，敞开的 T 没有滤过能力，与不存在一样。

对于这样的装置，概率幅可以如下写出
$$ \sum_{i 遍及 T 的基础态}\braket{0S\enspace|\enspace i}\braket{i\enspace| +S} = \braket{0S\enspace| +S}=0. $$
$$ \sum_{i 遍及 T 的基础态}\braket{+S\enspace|\enspace i}\braket{i\enspace| +S} = \braket{+S\enspace| +S}=1. $$

这可以推广到普遍的形式，设 $\varphi$ 和 $\chi$ 为粒子的始态和末态，有以下等式成立
$$ \braket{\chi|\varphi} = \sum_{i} \braket{\chi|i}\braket{i|\varphi}. $$
需要注意， $i$ 遍及某一过滤器的所有基础态，更专业一点的说法是**在某一组表象(representation)中的**基础态。

还有一条性质也理当导出。之前我们写出了一组基础态概率和为 1 的式子

$$
\begin{aligned}
&\braket{+T | +S}^*\braket{+T | +S} + \braket{0T| +S}^*\braket{0T| +S}\\
&+\braket{-T | +S}^*\braket{-T | +S} = 1.
\end{aligned}
$$

对于 $\braket{\chi|\varphi}$，取 $\chi$、$\varphi$ 均为 +S，展开有

$$
\begin{aligned}
&\braket{+S | +T}\braket{+T | +S} + \braket{+S|\enspace 0T}\braket{0T|+S}\\
&+\braket{+S | -T}\braket{-T | +S} = 1.
\end{aligned}
$$

观察上述式子，由于 T 的各态的纯粹性，则需要满足

$$
\begin{aligned}
\braket{+S | +T}&=\braket{+T | +S}^*\\
\braket{+S |\enspace 0T}&=\braket{0T| +S}^*\\
\braket{+S | -T}&=\braket{-T | +S}^*
\end{aligned}.
$$

综上就可以导出概率幅的三条性质：

1. 基础态两两正交：$ \braket{j | i}=\delta_{ij}. $
2. 基础态的完全分解：$ \braket{\chi|\varphi} = \sum\limits_i \braket{\chi|i}\braket{i|\varphi}. $
3. 共轭对称性：$ \braket{\chi|\varphi} =\braket{\varphi|\chi}^*. $

### 态矢量(state vector)

或许各位早已发现，比对概率幅的分解 $$ \braket{\chi|\varphi} = \sum_i \braket{\chi|i}\braket{i|\varphi}, $$ 与两个矢量的内积 $$ \boldsymbol{B\cdot A}=\sum_i (\boldsymbol{B\cdot \varepsilon_i})(\boldsymbol{\varepsilon_i\cdot A}), $$

我们似乎将其可以类比为内积空间(inner product space)中的矢量。

- **态矢量：**

    我们现在终于可以说明符号 $\bra{}$ 与 $\ket{}$ 的含义。这是狄拉克发明的符号，其将概率幅内积的右因子记为 $\ket{\varphi}$，称之为右矢(ket)，而 $\bra{\chi}$ 被称为左矢(bra)。如果形象一点理解就是，左矢为行向量，右矢为列向量。

- **左矢空间与右矢空间：**

    左矢与右矢分别定义在左矢空间与右矢空间中，这两个空间是对偶空间，即一个 $\bra{\varphi}$ 总对应有一个 $\ket{\varphi}$，两者均定义了加法和数乘。而后规定内积为 $\braket{\chi|\varphi}$，其将一对左矢与右矢映射到概率幅(也即是波函数)所在的空间。内积的性质与定义类似线性代数中复向量空间的定义，可以参考 [Linear Algebra Done Right](https://linear.axler.net/LADR4e.pdf) 当中 $Inner Product Spaces$ 章节。

- **基础态与基矢量：**

    先前使用施特恩-格拉赫装置纯化的一组基矢量就对应左矢空间或右矢空间中的一组规范正交基，其被称为一组**表象**，由此可以写出态矢量的“坐标”
    $$ \ket{\varphi}=\sum_i \ket{i}\braket{i|\varphi}. $$

!!! note "算符(operator)"

    算符其实就是映射，其作用在一个右矢上，得到另一个右矢。$$ A\ket{\varphi}=\ket{\psi}. $$
    物理上的理解是其状态经过某个仪器测量的影响后，变成了新的状态。
    
    **相关常用概念**：
    
    - 恒等映射
        
        我们可以写出以下映射 $$ |=\sum_i\braket{i|i}. $$
        等号左边即为恒等映射，等号右边就可以看作一个单位矩阵。

    - 伴算符(adjoint operator)

        伴算符是作用在左矢上的算符，符号为 $A^\dagger$，实际上就是将 $A$ 的矩阵做共轭转置。任意一个 $A\ket{\varphi}$ 总对应有一个 $\bra{\varphi}A^\dagger$。

    - 厄米算符(Hermitian operator)

        即自伴算符，满足 $ A=A^\dagger. $

    - 幺正算符(Unitary operator)
  
        即算符是等距同构的，满足 $ AA^\dagger = A^\dagger A = I. $

    **算符的使用与物理内涵：**
    $$ \braket{\chi | A | \varphi}. $$
    如果在左矢和右矢中间加上算符 $A$，从数学上看，其就等价于内积 $\langle\chi,A\varphi\rangle$，即将右矢经过映射之后与左矢做内积。

    从物理上解释这个式子，它表示处于 $\varphi$ 态的粒子经过仪器 $A$ 作用之后，进入 $\chi$ 态的概率幅。

    类比线代知识我们也可以写出在一组规范正交基下算符 $A$ 对应的矩阵：
    $$
    \begin{pmatrix}
        \braket{i|A|j}
    \end{pmatrix}.
    $$
    根据矩阵就可以将上述式子对应的概率幅展开写出：
    $$ \braket{\chi | A | \varphi}=\sum_{i, j}\braket{\chi |i}\braket{i|A|j}\braket{j|\varphi}. $$

### 哈密顿矩阵(Hamitonian matrix)

考虑这样一个特殊的算符 $U(t_2,t_1)$，它表示粒子在装置中从时间 $t_1$ 等待到 $t_2$，则经过该装置后粒子态矢量就可以写作 $$ \ket{\psi(t_2)}=U(t_2,t_1)\ket{\psi(t_1)}. $$

将态矢量在一组表象下的分量写出 $$ \sum_i\braket{i|\psi(t_2)}=\sum_i\braket{i|U(t_2,t_1)|\psi(t_1)}. $$

考虑其中一个分量，取 $ \Psi_i(t)=\braket{i|\psi(t)} $，这就是粒子在该基础态分量下的波函数。令 $t_2 = t_1+\Delta t$，也就是考虑原本处于 $\psi(t)$ 状态的粒子，经过 $\Delta t$ 之后它的状态变化，有

$$
\begin{aligned}
\Psi_i(t+\Delta t)&=\braket{i|U(t+\Delta t, t)|\psi(t)}\\
&=\sum_j\braket{i|U(t+\Delta t, t)|j}\braket{j|\psi(t)}\\
&=\sum_j U_{ij}(t+\Delta t, t)\Psi_j(t).
\end{aligned}
$$

其中 $U_{ij}$ 即为矩阵 $U$ 的第 $i$ 行第 $j$ 列分量。

如果将波函数写成矢量形式，可以将上式写成更简单的形式 $$ \boldsymbol{\Psi}(t+\Delta t)=U(t+\Delta t, t)\boldsymbol{\Psi}(t). $$

而后，我们考虑将这个算符做一些变换。显然，当 $\Delta t \to 0$，不会发生任何变化，$U$ 是一个单位矩阵。因此对 $U(t+\Delta t, t)$ 的每个分量做零附近的一阶展开，有 $$ U_{ij}=\delta_{ij}+K_{ij}\Delta t. $$

??? tip "克罗内克符号"
    还记得 $\delta_{ij}$ 是啥吗？其术语称为克罗内克符号，定义如下：

    $$
    \delta_{ij}=\boldsymbol{\hat{e}_i\cdot \hat{e}_j}=\left\{\begin{aligned}
        1,\quad i=j\\
        0,\quad i\neq j
    \end{aligned}\right.
    $$

由于历史和某些其他原因，可以将 $K_{ij}$ 写成 $\frac{1}{i\hbar}H_{ij}$，其中分母上的 $i$ 表示虚数单元，则可将上式改写为 $$ U_{ij}=\delta_{ij}+\frac{1}{i\hbar}H_{ij}\Delta t. $$
矩阵形式 $$ U(t+\Delta t, t)=I+\frac{1}{i\hbar}\hat{H}(t)\Delta t. $$

带入原方程可得 $$ \frac{\boldsymbol{\Psi}(t+\Delta t)-\boldsymbol{\Psi}(t)}{\Delta t}=\frac{1}{i\hbar}\hat{H}(t)\boldsymbol{\Psi}(t). $$

最终我们得到了**在离散情况下的薛定谔方程** $$ i\hbar\frac{\partial\boldsymbol{\Psi}(t)}{\partial t}=\hat{H}(t)\boldsymbol{\Psi}(t). $$

??? info "关于薛定谔与薛定谔方程"
    这里我们从矩阵和线代的角度推导出了薛定谔方程，但事实上一个世纪之前的物理学家对于矩阵相当陌生，他们更习惯通过微积分作推导。事实上薛定谔最初写出的方程形式也并非如此，他从哈密顿-雅可比方程着手，研究氢原子外电子的波动力学方程，推导出连续情况下的薛定谔方程形式为 $$ \hat{\mathscr{H}}\Psi(\boldsymbol{r},t)=\hat{\mathscr{E}}\Psi(\boldsymbol{r},t). $$
    式中 $\hat{\mathscr{H}}$ 就为电子的哈密顿算符，$\hat{\mathscr{E}}$ 为电子的能量算符。在讨论过连续体系的能量算符和哈密顿算符后，也可以将此展开写做 $$ (-\frac{\hbar^2}{2m}\nabla^2 + V(\boldsymbol{r}))\Psi(\boldsymbol{r},t)=i\hbar \frac{\partial}{\partial t}\Psi(\boldsymbol{r},t). $$

    有意思的是，当时物理学家尚不清楚如何诠释波函数，薛定谔试图以电荷密度来诠释波函数的绝对值平方，可并不成功。后来玻恩采用概率幅来诠释波函数，其平方就为量子行为的概率，现实来看成功地诠释了波函数的物理意义，被称为**哥本哈根诠释**。
    
    但是爱因斯坦与薛定谔本人都不赞成这种概率诠释，他们认为世界应当是决定性的。爱因斯坦的那句话，“它不掷骰子”(后人理解为“上帝不掷骰子”)，流传至今；而薛定谔则被戏称为“薛定谔不懂薛定谔方程”。

这里我们需要来关心矩阵 $H$。它被称为哈密顿量、哈密顿矩阵，或者简称哈密顿等等，反正都是同一个含义。

对于不同的量子体系，只要得到哈密顿矩阵的形式，剩下的就是解方程。所以关键就在：找出你的**哈密顿**！

## 哈密顿量

### 定态(stationary state)

考虑一个静止的电子，其动量的不确定量为零，因此，它的能量 $\varepsilon_0$ 是确定的。当然，其位置的不确定量就是无穷大，也就是说在各处找到他的概率幅相等，则其概率幅可写做 $$ \varphi=ae^{-i\omega t}=ae^{-i\frac{\varepsilon_0}{\hbar}t}. $$
式中用到了 $ \varepsilon_0=\hbar\omega $ 的条件。

对于这个体系，粒子没有受到任何作用，外界物理条件不变，则哈密顿量与时间无关。因此可以求解薛定谔方程 $$ i\hbar \frac{\partial \varphi(t)}{\partial t}=H_{11}\varphi(t), $$
得到 $$ \varphi=ae^{-i\frac{H_{11}}{\hbar}t}. $$

我们发现 $ H_{11}=\varepsilon_0 $，这就是一个定态的能量与哈密顿量关系的特例。更一般地，对于一个定态 $\ket{\eta}$，可以写出 $$ \hat{H}\ket{\eta}=\varepsilon\ket{\eta}. $$
可以发现，一个定态的能量就是哈密顿矩阵的本征值，而该定态就是哈密顿矩阵的本征态矢量。

定态有如下等价表述：

- 外势场 $V(\boldsymbol{r})$ 不随时间变化。
- 具有确定能量的状态。
- 体系的空间分布和各物理量取值概率不随时间改变的状态。

### 平均能量

现在，我们想求一个非定态 $\ket{\psi}$ 的能量。我们找到一组特殊的基础态 $\ket{\eta_i}$，其中每个都是定态，具有确定能量 $\varepsilon_i$。将 $\ket{\psi}$ 投影到其上， $$ \ket{\psi}=\sum_i \ket{\eta_i}\braket{\eta_i | \psi}. $$
不妨取 $z_i=\braket{\eta_i | \psi}$，则对于态 $\ket{\psi}$，测量到其能量为 $\varepsilon_i$ 的概率等于其进入基础态 $\eta_i$ 的概率，有 $$ P_i=z_iz_i^*. $$
则平均能量 $$ \overline{E}=\sum_i P_i\varepsilon_i. $$

我们写成如下形式

$$
\begin{aligned}
\overline{\varepsilon}&=\sum_i z_i^*\varepsilon_iz_i\\
&=\sum_i\braket{\psi|\eta_i}\varepsilon_i\braket{\eta_i|\psi}\\
&=\bra{\psi}\left\{ \sum_i\ket{\eta_i}\varepsilon_i\braket{\eta_i|\psi} \right\}\\
&=\bra{\psi}\left\{ \sum_i\varepsilon_i\ket{\eta_i}\braket{\eta_i|\psi} \right\}.
\end{aligned}
$$

由定态条件 $ \hat{H}\ket{\eta_i}=\varepsilon_i\ket{\eta_i} $，可将大括号内的式子写成 $$ \hat{H}\sum_i\ket{\eta_i}\braket{\eta_i|\psi}. $$
而右边求和后就等于 $\ket{\psi}$。

非常美妙地，最终我们得到 $\ket{\psi}$ 的平均能量 $$ \overline{\varepsilon}=\braket{\psi|\hat{H}|\psi}. $$

### 哈密顿量的物理含义

取一组表象，不妨假定仅有两个基础态(不一定是定态)，分别为 $\ket{1}、\ket{2}$，考虑哈密顿矩阵与基础态平均能量之间的关系。

$$
\hat{H}=\begin{pmatrix}
H_{11} & H_{12}\\
H_{21} & H_{22}
\end{pmatrix}\\[5mm]
H_{11}=\braket{1|\hat{H}|1}、H_{12}=\braket{1|\hat{H}|2}...
$$

我们发现 $H_{11}$ 实际上就是态 $\ket{1}$ 的平均能量，即**哈密顿矩阵对角线给出我们所研究系统各态的平均能量**。

至于非对角线上的量，比如 $H_{12}$，它表示的是系统从 $\ket{1}$ 跃迁到 $\ket{2}$ 的耦合能量，或者说耦合系数，其值越大，表示跃迁发生的概率越大。

最终，恭喜你一步步推导出了薛定谔方程与哈密顿量，并且弄懂了哈密顿量的物理内涵！或许你依然对量子力学抱持怀疑的态度，不认可中间的推演，甚至不认可量子的前提，你可能感觉量子力学好像比相对论还魔幻。没关系，没有人真正“懂”量子。或许今后的漫长岁月里，人类依然无法明晓量子力学那些原理背后的机理(有没有机理都不好说呢)，但是，当我们只关心“可观测”的东西，不去在意它们背后的“混沌”，量子力学依然可以为人所利用，一定程度上这也就足矣。

<span style="font-family: Brush Script MT;font-size:26px">
Physics has given up on the problem of trying to predict exactly what will happen in a definite circumstance.We can only predict the odds!
</span>

<span style="float: right; font-family: Brush Script MT;font-size:26px">
Richard Feynman
</span>
