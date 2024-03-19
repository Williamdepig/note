---
counter: True
comment: True
---

# 电容器与电介质

## 电容、电容器

- **平行极板：**

    ![平行板](/assets/images/physics/General_Physics_2/parallel.png)
    不考虑边缘效应(事实上在普物里总是不会考虑的)，板内电场大小 $E=\sigma/\epsilon_0$，板外为零。因此板间存在有电势差，也常叫做“电压”，记为 $V$
    $$
    V=Ed=\frac{\sigma}{\epsilon_0}d=\frac{d}{\epsilon_0A}Q，
    $$
    式中 $Q$ 为每块板上的总电荷，$A$ 为板面积，而 $d$ 为板间距离。

    可以发现电压与电荷成正比。对于空间中任意两个导体构成的一个系统，只要两者带**等量异种电荷**，$V$ 与 $Q$ 间的正比性就存在。这种正比性源于叠加原理，导体间电荷相互吸引导致电荷分布形式总是相同的，仅有电荷量的差别，因此电荷加倍，电场也加倍，电势差也就是电场对路径的积分也加倍，则有电压与电荷成正比。可以写成
    $$
    Q=CV,
    $$
    式中比例常数 $C$ 也就是电容，这样一种两个导体的系统就称为电容器。不过其实电容器的要求并不如此严苛，事实上核心就是一种施加电压来储存电荷的装置，对于封闭性、导体个数都没有严格定义。

- **孤立导体球：**

    对于一个孤立导体球，其另一块极板可以看作无穷远处，或者设想有一个半径无限大的导体球(大地)。导体球电势为
    $$
    V=\frac{Q}{4\pi\epsilon_0R},
    $$
    则有电容
    $$
    C=\frac{Q}{V}=4\pi\epsilon_0R.
    $$

- **同轴电缆：**

    ![同轴圆柱](/assets/images/physics/General_Physics_2/coaxial_cylinder.png)

    如图，电容器由两个同轴柱形导体组成，长度远大于两者半径，设导体上线电荷密度为 $\lambda$，内侧为正，外侧为负。显然由高斯定理，取圆柱形高斯面可以解得导体间空腔电场为 $E=\frac{\lambda}{2\pi\epsilon_0r}$，沿轴向分布。两圆柱电极间电压为
    $$
    V=\int_A^B\boldsymbol{E}\cdot\mathrm{d}\boldsymbol{r}=\int_{R_A}^{R_B}\frac{\lambda}{2\pi\epsilon_0}\cdot\frac{1}{r}\mathrm{d}r=\frac{\lambda}{2\pi\epsilon_0}\ln\frac{R_B}{R_A}.
    $$
    电容器一个电极上储存的总电荷为 $Q=\lambda L$，故同轴电缆的电容公式为
    $$
    C=\frac{Q}{V}=\frac{2\pi\epsilon_0L}{\ln\frac{R_B}{R_A}}.
    $$

- **同心球型电容：**

    同样的分析，电容器由两个同心球型导体A和B组成，设半径分别为 $R_A$ 和 $R_B(R_A<R_B)$。
    其各自带有电荷 $\pm Q$，则导体间电场 $E=\frac{Q}{4\pi\epsilon_0r^2}$。两电极间电压就为
    $$
    V=\int_{R_A}^{R_B}\frac{Q}{4\pi\epsilon_0}\frac{1}{r^2}\mathrm{d}r=\frac{Q}{4\pi\epsilon_0}\frac{R_B-R_A}{R_AR_B}.
    $$
    电容就为
    $$
    C=\frac{Q}{V}=\frac{4\pi\epsilon_0R_AR_B}{R_B-R_A}.
    $$

## 电容器储能

考虑电源对一个不带电的电容器的充电过程，则电源对它做的功就是电容器储能。

已知当电容器带电 $Q$ 时，有电压 $V=\frac{Q}{C}$。充电过程就是逐步把电荷微元 $\mathrm{d}Q$ 从负极板移动到正极板，则转移电荷过程做功
$$
\mathrm{d}W=V\mathrm{d}Q=\frac{Q}{C}\mathrm{d}Q，
$$
从零电荷积分到最后带电荷 $Q$，就有总功
$$
W=\frac{1}{2}\frac{Q^2}{C}.
$$
这就是电容器储能公式，分别有三种形式，题目通常只给出电压和电容，因此第二个形式用的比较广泛，不过三者是完全等价的。
$$
W_e=\frac{1}{2}\frac{Q^2}{C}=\frac{1}{2}CV^2=\frac{1}{2}QV.
$$

- 电容器储能与电场能

    考虑最简单的平行板电容器，其储能
    $$
    W_e=\frac{Q^2}{2C}=\frac{Q^2d}{2\epsilon_0A}.
    $$
    由于仅平行板间存在电场(不考虑边缘效应)
    $$
    E=\frac{\sigma}{\epsilon_0}=\frac{Q}{\epsilon_0A},
    $$
    可以发现储能与电场的关系
    $$
    W_e=\frac{(E\cdot\epsilon_0A)^2d}{2\epsilon_0A}=\frac{1}{2}\epsilon_0E^2Ad.
    $$
    由于电容器体积 $V=Ad$，因此亦可得到电场能密度
    $$
    u=\frac{1}{2}\epsilon_0E^2.
    $$
    这也是静电能储存在电场中的一个佐证。

- ***电容器的串并联***

## 电介质

该部分相对而言容易考解答题，并且一部分概念相当容易混淆，建议将该章节完整看完，再找历年题做一下相应的题目(基本是大题)。

### 极化微观机理

- 导体：可以“无限”提供被约束在内部的自由电子的一类物体。其微观实质是，许多电子不被原子核约束，而可以在导体中自由移动。
- 绝缘体(或者说电介质)：所有电子都被束缚于特定的原子或者分子，只能产生微小的位移。这种位移可以解释电介质的电学特性，也就是所谓的**极化**。

极化本质上就是正负电荷中心发生偏移导致产生电场的过程，不过从微观上会有两种不同机制导致极化：电荷偏移或者极性分子的旋转。接下来会粗略地讲解这两种机制以帮助理解宏观上极化现象的本质。

- 无极分子和原子的位移极化：

    当中性的原子放置在外电场中，带正电的原子核会沿电场方向移动，带负电的电子云则会向着相反方向，两者位移一定距离后重新平衡，此时正负电荷中心不重合，原子**被极化**。此时原子产生了一个微小的偶极矩 $\boldsymbol{p}$，其与电场 $\boldsymbol{E}$ 同向。如果电场足够大，可以电离原子，使得电子脱离原子核成为自由电子，宏观上表现为电介质被“击穿”成为导体。

- 极化分子的取向极化：

    某些分子本身正负电荷中心就并不重合，具有固有偶极矩，被称为极化分子。例如水分子的氢原子和氧原子三者并不排列在一条直线上，导致正负电荷中心存在固有偏移。当它被放置在外电场中时，偶极子会受到力矩
    $$
    \boldsymbol{M}=\boldsymbol{p}\times\boldsymbol{E},
    $$
    使得其倾向于向着电场方向转动。原本方向无序的一大团分子在外电场作用下有序排列，表现在宏观上也就是发生了极化。

两种机制表现在宏观上的效果是类似的，最终都表现为一侧带有负电，另一侧带有正电，中间产生能一定程度上抵消外电场的反向电场。

### 极化强度

为了从宏观上描述电介质内的极化状况，需定义一个矢量 $P$，其物理含义为单位体积内偶极矩的矢量和，即
$$
\boldsymbol{P}=\frac{\sum \boldsymbol{p}}{\Delta V}.
$$
这被称作**极化强度矢量**。接下来会研究极化强度矢量与原电场以及电介质的宏观属性之间的关系。

- **极化电荷**

    电介质被极化后的束缚电荷都是真实的会产生电学效应的电荷，需要计算这些电荷分布与极化强度之间的关系。考虑一个平行于 $\boldsymbol{P}$ 的微小圆柱，面积为 $A$，厚度为 $d$。则根据极化强度的定义，其偶极矩就为 $P\cdot (Ad)$。假设一端的电荷量为 $q$，由于偶极矩就为 $qd$，则有 $q=PA$，因此**表面**的电荷面密度就为
    $$
    \sigma'=\frac{q}{A}=P
    $$
    ![极化面电荷](/assets/images/physics/General_Physics_2/polarized_surface_charge.png)
    如果截面与极化强度矢量有夹角 $\theta$，则电荷依然相同，但是截面面积增大，有 $A_{end}=A/\cos\theta$，所以有极化面电荷密度与极化强度矢量的关系
    $$
    \sigma'=\frac{q}{A_{end}}=P\cos\theta=\boldsymbol{P}\cdot\boldsymbol{\^{n}}
    $$
    注意，在**均匀极化**情况下，即极化强度矢量处处相等时，内部的正负电荷会相互“抵消”，造成的效果就是只在电介质表面产生面电荷密度。如果是非均匀极化情况，还可能在电介质内部产生体电荷密度分布。

    依然是取一个高斯面 $S$，则正束缚电荷会被排挤到曲面外，因此有内部的净电荷
    $$
    \Delta Q_{极化}=-\oiint \sigma'\mathrm{d}S=-\oiint \boldsymbol{P}\cdot\mathrm{d}\boldsymbol{S}.
    $$
    ![极化高斯面](/assets/images/physics/General_Physics_2/gauss_surface.png)
    又有 $\Delta Q_{极化}=\iiint\rho'\mathrm{d}V$，再用高斯定理可得
    $$
    \iiint\rho'\mathrm{d}V=-\oiint \boldsymbol{P}\cdot\mathrm{d}\boldsymbol{S}=-\iiint (\nabla\cdot \boldsymbol{P})\mathrm{d}V,
    $$
    由于对任意体积成立，就有结果
    $$
    \rho'=-\nabla\cdot\boldsymbol{P}.
    $$
    需要强调，这些电荷都是**真实**的电荷密度，只是为了区分来源，才叫做“极化电荷”或者“束缚电荷”。

### 含电介质时的静电方程组

!!! note "含电介质的高斯定理推导"
    电介质中除了束缚电荷会产生电场，还可能有导体的电荷、嵌入电介质的离子或者其他电荷(统称自由电荷)会引起电场并参与静电方程组。因此在电介质中的总电荷可以写作
    $$
    \rho=\rho_0+\rho'.
    $$
    式中 $\rho_0$ 就为自由电荷体密度，$\rho'$ 就为束缚电荷，而 $\rho$ 则是总电荷。

    因此高斯定理就可以写作
    $$
    \epsilon_0\nabla\cdot\boldsymbol{E}=\rho=\rho_0+\rho'=\rho_0-\nabla\cdot\boldsymbol{P}.
    $$
    **注意**，式中的 $\boldsymbol{E}$ 是总电场，而非初始外电场或者束缚电荷产生的退极化场。

    将散度项合并可以发现
    $$
    \nabla\cdot(\epsilon_0\boldsymbol{E}+\boldsymbol{P})=\rho_0.
    $$
    将括号中的表达式用字母 $\boldsymbol{D}$ 表示
    $$
    \boldsymbol{D}=\epsilon_0\boldsymbol{E}+\boldsymbol{P}.
    $$
    其被称为**电位移矢量**。这样就得到了有电介质时的高斯定理
    $$
    \nabla\cdot\boldsymbol{D}=\rho_0.
    $$
    积分形式即为
    $$
    \oiint\boldsymbol{D}\cdot\mathrm{d}\boldsymbol{S}=Q_0.
    $$
    式中 $Q_0$ 就是体积内的总自由电荷，而自由电荷可控，并且通常会直接在题目中给出。因此在对称性好得时候，$\boldsymbol{D}$ 是容易求得的。

**但是**，需要强调的是，电位移矢量仅仅是为了便于求解存在电介质情况下的静电分布而引入的数学符号，它本身不具有电场的大多数性质。比如，对于电位移矢量而言，库仑定律不一定成立，并且环路积分也不一定为零，因此也没有“势”的概念。

接下来要引入电位移矢量与电场和极化强度之间的关系。

### 电极化率、介电常数

实验发现，当电场并不特别强时，极化强度与电场成正比
$$
\boldsymbol{P}=\epsilon_0\chi_e\boldsymbol{E}.
$$
式中 $\chi_e$ (读音kai)被称为**电极化率**，满足该关系的被称为线性电介质。事实上 $\chi_e$ 是一个张量，

$$
\begin{pmatrix}
    P_x \\
    P_y \\
    P_z
\end{pmatrix}=
\begin{pmatrix}
    \chi_{xx} & \chi_{xy} & \chi_{xz} \\
    \chi_{yx} & \chi_{yy} & \chi_{yz} \\
    \chi_{zx} & \chi_{zy} & \chi_{zz}
\end{pmatrix}
\begin{pmatrix}
    \epsilon_0E_x \\
    \epsilon_0E_y \\
    \epsilon_0E_z
\end{pmatrix}
$$

不过通常题目遇见的都是各向同性的，即并不需要考虑方向，电极化率是常数。

依然需要强调的是，式中 $\boldsymbol{E}$ 是总电场，即外电场与束缚电荷产生电场的叠加。我们可以通过电位移矢量来得到电场与极化强度分布。

在线性电介质中
$$
\boldsymbol{D}=\epsilon_0\boldsymbol{E}+\boldsymbol{P}=\epsilon_0(1+\chi_e)\boldsymbol{E}.
$$
定义一个新的物理量 $\kappa_e$，
$$
\kappa_e=1+\chi_e,
$$
就有电位移矢量与电场关系
$$
\boldsymbol{D}=\kappa_e\epsilon_0\boldsymbol{E}.
$$
这个常数被称作该材料的相对介电常数。令 $\epsilon=\kappa_e\epsilon_0$，其被称为该材料的介电常数。三个常数只用知道一个就可以得到另外两个，不过是 $\chi_e$ 用在极化强度，而 $\kappa_e$ 用在电位移矢量罢了。

有了以上关系，就足以求解电介质中的电场电荷分布了。

### 线性电介质举例

- **电介质球壳**
    半径为 $a$ 的金属球带电荷量为 $Q$，被一个相对介电常数 $\kappa_e$ 且外径为 $b$ 的线性电介质包裹。

    ![电介质球壳](/assets/images/physics/General_Physics_2/metal_dielectric.png)

    先计算电位移矢量，由于自由电荷量就为 $Q$，使用含电介质高斯定理易得
    $$
    \boldsymbol{D}=\frac{Q}{4\pi r^2}\boldsymbol{\^{r}}.
    $$
    其对于 $r>a$ 处恒成立。再根据电场与电位移矢量的关系可得

    $$
    \boldsymbol{E}=\left\{
    \begin{aligned}
    &\frac{Q}{4\pi\kappa_e\epsilon_0r^2}\boldsymbol{\^{r}},& a<r<b\\
    &\frac{Q}{4\pi\epsilon_0r^2}\boldsymbol{\^{r}},& r > b
    \end{aligned}\right.
    $$

    自然也可以计算电介质中的极化强度(虽然没必要)。
    $$
    \boldsymbol{P}=(\kappa_e-1)\epsilon_0\boldsymbol{E}=\frac{(\kappa_e-1)Q}{4\pi\kappa_er^2}\boldsymbol{\^{r}}
    $$

- **均匀极化球**
    这是一个经典模型，一个电介质球在外电场 $\boldsymbol{E}$ 中被均匀极化，求介质球中的电场、极化强度与面电荷分布。

    ![均匀极化球](/assets/images/physics/General_Physics_2/uniformly_polarized_sphere.png)

    图中直观地展示出束缚电荷在外场中的极化情况，也就是正负电荷中心偏移，可以用两个均匀带电球来表征或者说**模拟**。没有极化时，两个球重合；当介质球被均匀极化后，两个球产生微小的偏移 $d$，因而在球中间相互抵消，而表面产生面电荷。

    假设体电荷密度为 $\rho_e$，则一个球上的总电荷量为 $Q=\rho_e\cdot\frac{4}{3}\pi R^3$。由高斯定理易得在均匀带电球内的电场为
    $$
    \boldsymbol{E} = \frac{\rho_e}{3\epsilon_0}\boldsymbol{r},
    $$
    则有两球叠加产生的电场
    $$
    \boldsymbol{E'} = \frac{\rho_e}{3\epsilon_0}\boldsymbol{r_1}+\frac{-\rho_e}{3\epsilon_0}\boldsymbol{r_2}=-\frac{\rho_e}{3\epsilon_0}\boldsymbol{d}.
    $$
    又由极化强度的定义
    $$
    \boldsymbol{P} = \frac{\sum \boldsymbol{p}}{\Delta V} = \frac{Q\boldsymbol{d}}{\frac{4}{3}\pi R^3} = \rho_e \boldsymbol{d}.
    $$
    因此得到了此处所谓“**退极化场**”与极化强度的关系
    $$
    \boldsymbol{E'} = -\frac{\boldsymbol{P}}{3\epsilon_0}.
    $$
    课堂上应该对退极化场的概念有所讲述，它是在电介质极化后，束缚电荷产生的反向电场。作用上它会使得电介质内场强减小，但由于极化强度本身与电场有正比关系，所以也就导致极化效果减弱，这就是“退极化”的由来。不过事实上退极化场并不重要，也不参与到前文静电方程组中，此处提出这个概念仅仅方便解题。

    需要注意的是，电介质球自然不会是两个均匀带电球的叠加，此处仅仅用来模拟，仅因为二者的电场与电荷分布相同罢了。

    介质球表面的面电荷密度分布也很简单，
    $$
    \sigma_e' = \boldsymbol{P}\cdot\^{n} = P\cos\theta = \rho_e d \cos\theta.
    $$
    如果再引入外场 $\boldsymbol{E_0}$，假设相对介电常数为 $\kappa_e$，则有关系
    $$
    \boldsymbol{E} = \boldsymbol{E_0} + \boldsymbol{E'},
    $$
    以及
    $$
    \boldsymbol{P} = \epsilon_0(\kappa_e-1)\boldsymbol{E}.
    $$
    再联立之前退极化场和极化强度的关系，就可以解得总电场
    $$
    \boldsymbol{E} = \frac{3}{\kappa_e+2}\boldsymbol{E_0}.
    $$
