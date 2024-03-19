---
counter: True
comment: True
---

# 稳恒电流

!!! info
    在往年，该章节通常讲的知识点繁多但是大都很简略，在考题中涉及很少，并且比较简单，偶尔会成为大题中的一小问或者一个解题要点，不过作业会有对应题目(虽然可以抄作业bushi)。

    本章节首先从微观层面解释电流的形成，而后在宏观上进行电路分析。

## 恒定电流与导电规律

### 电流 电流密度矢量

- **电流：** 单位时间内通过导体一截面的电荷量。规定正电荷流动方向为电流方向。则导体中电流方向总沿电场方向，从高电势流向低电势。
    $$
    I = \frac{\Delta q}{\Delta t} \quad (=nqSv).
    $$
    后面括号中的内容是高中学过的电流微观表达式，会在讲霍尔效应中派上用场。$n$ 是载流子体密度，$q$ 是单个载流子电荷量，$S$ 为垂直截面面积，$v$ 是载流子流速。
- **电流密度矢量：** 通过空间中某点的单位垂直截面上的电流及其方向，通常用 $\boldsymbol{j}$ 表示。

    $$
    \mathrm{d}I=\boldsymbol{j}\cdot\mathrm{d}\boldsymbol{S}.\\
    I=\iint_S\boldsymbol{j}\cdot\mathrm{d}\boldsymbol{S}=\iint_S\boldsymbol{j}\cdot\boldsymbol{\^{n}}\mathrm{d}S.
    $$

    由此可见，电流密度与电流的关系就是一个矢量场与它的通量这样的关系。

### 电流连续方程 恒定条件

取一闭合曲面 $S$，某段时间内从此面流出的电荷量等于面内包含的电荷量的减少值，即
$$
\oiint_S\boldsymbol{j}\cdot\mathrm{d}\boldsymbol{S}=-\frac{\mathrm{d}q}{\mathrm{d}t}.
$$
这便是**电流连续方程**。显然它的实质就是电荷守恒定律。

在**恒定电流**中，电流场不随时间改变，由于电流由电场引起，而电场又有电荷发出，则根本上就是电荷分布不随时间改变，即对于任意的闭合曲面，有 $\frac{\mathrm{d}q}{\mathrm{d}t}=0$，这样就可以得到
$$
\oiint_S\boldsymbol{j}\cdot\mathrm{d}\boldsymbol{S}=0.
$$
这就是电流的恒定条件。直观一点讲就是一侧流入，等于另一侧的流出，不会在某处地点积累。

### 欧姆定律微分形式

- **欧姆定律：** $\quad I=\frac{U}{R}$
- **电阻公式：** $\quad R=\rho\frac{L}{S}$

从微观上再来看待欧姆定律，取一段微元电流管，长度为 $\Delta l$，面积为 $\Delta S$。
![电流管](/assets/images/physics/General_Physics_2/current_pipe.png)

应用欧姆定律，有
$$
\Delta I=\frac{\Delta U}{R}
$$
再根据各物理量的定义，$\Delta I=j\Delta S$，电势差是电场的路径积分 $\Delta U=E\Delta l$，由电阻公式 $R=\rho\frac{\Delta l}{\Delta S}$，最终可以得到电流密度与电场的关系
$$
\boldsymbol{j}=\frac{1}{\rho}\boldsymbol{E}=\sigma\boldsymbol{E}
$$
式中 $\sigma$ 是电阻率 $\rho$ 的倒数，叫做电导率。该公式就是**欧姆定律的微分形式**。

### 电功率与焦耳定律

- **电功率：** $P=UI$
- **焦耳热功率：** $P_J=I^2R$

当电路中只有电阻元件，消耗的电能全变为热能时，上述二者相等。否则二者不相等，电功率是电路消耗的总功率，一般大于热功率。

## 电源与电动势

- **电动势：** 一个电源的电动势 $\varepsilon$ 定义为把单位正电荷从负极通过电源内部移动到正极的过程中，非静电力所做的功。
    $$
    \varepsilon=\int_-^+ \boldsymbol{K}\cdot\mathrm{d}\boldsymbol{l}.
    $$
- **路端电压：** 定义为把单位正电荷从负极通过电源内部移动到正极的过程中，静电场力做的功。
    $$
    U=\varepsilon\mp Ir.
    $$
    式中 $r$ 是电源内阻，$I$ 是经过电源的电流。当电源处在放电过程，也就是电流方向是从负极到正极时，式中取负号，即 $U=\varepsilon-Ir$；否则，电源处在充电过程，路端电压式中取正号。
- **闭合回路电流与输出功率：** 根据欧姆定律，有电流
    $$
    i = \frac{\varepsilon}{R+r},
    $$
    因此输出功率
    $$
    P_{out}=Ui=i^2R=\left(\frac{\varepsilon}{R+r}\right)^2R.
    $$
    显然，当 $R=r$ 时，输出功率最大。

## 简单电路

- 串联电路：
    $$
    R=R_1+R_2+...+R_n
    $$
    $$
    \frac{1}{C}=\frac{1}{C_1}+\frac{1}{C_2}+...+\frac{1}{C_n}
    $$
- 并联电路：
    $$
    \frac{1}{R}=\frac{1}{R_1}+\frac{1}{R_2}+...+\frac{1}{R_n}
    $$
    $$
    C=C_1+C_2+...+C_n
    $$

## *复杂电路

### 基尔霍夫方程

1. 节点电流方程：

    电源和电阻串联而成的通路叫**支路**，三条或以上支路的连接点叫做**节点**。对于一个节点，流入该节点的总电流等于流出该节点的总电流，可以写成
    $$
    \sum_i I_i = 0.
    $$
    这就是节点电流方程，电流取流入该节点为正。

2. 回路电压方程：

    几条支路构成的闭合通路叫做**回路**。沿一个回路环绕一周，电势不变，也就是电压降为零
    $$
    \sum_i\varepsilon_i+\sum_j I_jr_j=0
    $$
    指定电势降为正，电势升为负，这就是回路电压方程。

### 等效电压源

### 等效电流源

### 星三角变换

- 星形到三角形

    $$
    \left \{
    \begin{aligned}
    R_{12}&=\frac{R_1R_2+R_2R_3+R_1R_3}{R_3}\\
    R_{23}&=\frac{R_1R_2+R_2R_3+R_1R_3}{R_1}\\
    R_{13}&=\frac{R_1R_2+R_2R_3+R_1R_3}{R_2}
    \end{aligned}
    \right.
    $$

- 三角形到星形

    $$
    \left \{
    \begin{aligned}
    R_{1}&=\frac{R_{31}R_{12}}{R_{12}+R_{23}+R_{31}}\\
    R_{2}&=\frac{R_{12}R_{23}}{R_{12}+R_{23}+R_{31}}\\
    R_{3}&=\frac{R_{23}R_{31}}{R_{12}+R_{23}+R_{31}}
    \end{aligned}
    \right.
    $$

## *温差电
