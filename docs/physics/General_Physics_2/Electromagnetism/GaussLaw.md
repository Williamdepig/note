---
counter: True
comment: True
---

# 高斯定律的应用与经典静电场模型

## 线电荷、面电荷与体电荷

### 线电荷

- **无限长均匀线电荷**

    设线电荷密度为 $\lambda$，取如图所示的圆柱形高斯面，则有，
    $$
    E_r\cdot 2\pi rh=\frac{\lambda\cdot h}{\epsilon_0},
    $$
    即可得到径向电场
    $$
    E_r=\frac{\lambda}{2\pi\epsilon_0 r}.
    $$
    ![无限长](/assets/images/physics/General_Physics_2/infinite_line.png)

- **有限长均匀线电荷**

    仅以径向电场为例，其余同理。

    $$
    \begin{aligned}
    \mathrm{d}E_r&=\frac{1}{4\pi\epsilon_0}\cdot\frac{\lambda\mathrm{d}x}{r^2+x^2}\sin\theta=\frac{\lambda r}{4\pi\epsilon_0}\cdot\frac{\mathrm{d}x}{(r^2+x^2)^{\frac{3}{2}}},\\
    E_r&=\frac{\lambda r}{4\pi\epsilon_0}\int_{-x_1}^{x_2}\frac{\mathrm{d}x}{(r^2+x^2)^{\frac{3}{2}}}\\
    &=\frac{\lambda}{4\pi\epsilon_0 r}\left(\frac{x_1}{\sqrt{r^2+x_1^2}}+\frac{x_2}{\sqrt{r^2+x_2^2}}\right)\\
    &=\frac{\lambda}{4\pi\epsilon_0 r}(\cos\alpha-\cos\beta).
    \end{aligned}
    $$

    ![有限长](/assets/images/physics/General_Physics_2/finite_line.png)

### 面电荷；平行板

- **无限大面电荷**

    由于对称，两侧电场大小相同，方向垂直于电荷平面。设面电荷密度为 $\sigma$， 应用高斯定理可得
    $$
    E=\frac{\sigma}{2\epsilon_0}.
    $$

- **两块平行板间电场**

    叠加或者高斯定理均可得到
    $$
    E=\frac{\sigma}{\epsilon_0}.
    $$

![面电荷](/assets/images/physics/General_Physics_2/sheet.png)

### 球体；球壳

对于一个均匀分布有体电荷密度 $\rho$ 的球体，取一个球面作为高斯面，易得电场分布为

$$
E=\left\{
\begin{aligned}
&\frac{\rho r}{3\epsilon_0},&r<R\\
&\frac{\rho R^3}{3\epsilon_0r^2},&r\ge R
\end{aligned}\right.
$$

对于均匀薄球壳的分析是相同的，内部无电场，外部电场分布与点电荷类似。

这些特性事实上都来自于电场的平方反比规律，因此在很多情况下引力场也有类似特性。平方反比规律至少在原子尺度($10^{-10}\mathrm{m}$)下精确成立。

## 导体电场

以下几点是导体(在稳定状态下)的性质：

- 导体中电荷可以自由移动。
- 导体内部无电场。
- 导体表面是等势面(或者说导体上处处等势)。
- 导体表面的电场处处垂直于导体切面，大小为 $\frac{\sigma_e}{2\epsilon_0}$，$\sigma_e$ 是导体上该点的面电荷密度。
- **电磁屏蔽**：如果一个导体完全包裹了某个空腔，则外界的任何静止分布的电荷无法在腔内产生电场；同样的，腔内的静电荷分布也无法在导体外部产生任何电场。

这些性质均源于第一条性质，也就是导体中有大量自由电子，其仅受导体形状的约束。因此一旦导体中存在电势差，就会产生电场，进而导致电子的移动，破坏平衡状态。

## 电偶极子

取相距为 $l$ 的两个点电荷 $+q$ 与 $-q$。使用极坐标系，令极轴沿这两电荷的连线，并选取原点在其中间。可以得到电荷的电势为

$$
\phi(r,\theta)=\frac{1}{4\pi\epsilon_0}\left(\frac{q}{\sqrt{r^2+(l/2)^2-rl\cos\theta}}+\frac{-q}{\sqrt{r^2+(l/2)^2+rl\cos\theta}}\right).
$$

![偶极子](/assets/images/physics/General_Physics_2/dipole.png)

通常而言，我们会研究那些距离远大于电荷间距处的的电场，即 $r\gg l$，则泰勒展开化简得到电势
$$
\phi(r,\theta)=\frac{1}{4\pi\epsilon_0}\frac{p\cos\theta}{r^2},
$$
式中 $p=ql$，其被定义为**电偶极矩**。

应用极坐标梯度公式可以得到径向与切向电场

$$
\begin{aligned}
\boldsymbol{E}&=-\nabla\phi\\
&=-\left(\frac{\partial\phi}{\partial r}\boldsymbol{e_r}+\frac{1}{r}\frac{\partial\phi}{\partial\theta}\boldsymbol{e_\theta}\right)\\
&=\frac{1}{4\pi\epsilon_0}\frac{p\cos\theta}{r^3}\boldsymbol{e_r}+\frac{1}{4\pi\epsilon_0}\frac{p\sin\theta}{r^3}\boldsymbol{e_\theta}.
\end{aligned}
$$

- ***偶极子在外电场中的行为***

## *电像法

电像法是一种通过等效替代在实空间达到相同电势电场分布的思维与解题方法，它的理论根据是唯一性定理(不做证明)。*普物课程里应当不会讲这种方法，但是在某些考试题目中偶尔会涉及到*，因此姑且讲解两个最基础的模型应付考试即可。

- **点电荷与无穷大导体板**
![the method of images](/assets/images/physics/General_Physics_2/ImageMethod.png)
在一接地无穷大导体平板上方有一点电荷 $q$，则在实空间(点电荷 $q$ 一侧的空间)的电场电势分布等效于有一个镜像电荷 $-q$ 在对称位置，这一对电荷的电场电势分布。$q$ 受到的力就是 $-q$ 对它产生的电场力。像空间(点电荷 $q$ 对侧的空间)的电场由于静电屏蔽，实际为零。

- **点电荷与导体球**
![the method of images II](/assets/images/physics/General_Physics_2/ImageMethod2.png)
一接地导体球外侧有一点电荷 $q$。电像法实际是模拟相同的电势分布，只要满足镜像电荷与原电荷的等势面恰是该导体球面的形状即可。
假设有一个镜像点电荷在球内，由于导体球电势为零，若满足 $\frac{q}{r_1}+\frac{q'}{r_2}=0$，则这是一个阿波罗尼乌斯圆。调整参数大小使得球心离 $q$ 恰为 $b$，半径恰为 $a$，有镜像电荷 $q'=-\frac{a}{b}q$，离球心距离 $d=\frac{a^2}{b}$。

**注意：**

- 电场分布与电势分布仅在球外的区域成立，球内均为零。
- 如果导体球不接地，比如原本带有电荷 $Q$，则除去镜像电荷 $q'$ 后， 在球心额外有一个电荷 $q''=Q-q'=Q+\frac{a}{b}q$，如此不改变球面等势，也没有改变电荷总量，可以作为等效电荷分布。
