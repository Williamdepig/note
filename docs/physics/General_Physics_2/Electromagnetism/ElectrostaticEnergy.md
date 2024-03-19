---
counter: True
comment: True
---

# 静电能*

## 电荷的静电能

- **两个点电荷：**

    根据先前对点电荷电势的推导，可知将这两个点电荷从相距无穷远移动到相距 $r_{12}$，所要做的功为
    $$
    \frac{q_1q_2}{4\pi\epsilon_0r_{12}},
    $$
    这对电荷的**相互作用能**就为该值。由之后的推导可知，由于点电荷模型的特殊性，点电荷的自能发散，则这个电荷体系的总能量，也就是我们所说的**静电能**(包含自能与相互作用能，不过事实上**不用把自能和相互作用能这二者区分的十分清楚**)，就可以用这个值表征,即
    $$
    U_{12}=\frac{q_1q_2}{4\pi\epsilon_0r_{12}}.
    $$

- **多个点电荷：**

    对于复数个点电荷，根据叠加原理，总静电能等于所有电荷对的相互作用能之和，如果有 n 个点电荷，则有静电能

    $$
    \begin{aligned}
    U&=\sum_{所有电荷对}\frac{q_iq_j}{4\pi\epsilon_0r_{ij}}\\
    &=\frac{1}{4\pi\epsilon_0}\sum^n_{i=1}\sum^{i-1}_{j=1}\frac{q_iq_j}{r_{ij}}\\
    &=\frac{1}{4\pi\epsilon_0}\cdot\frac{1}{2}\sum^n_{i=1}\left(q_i\cdot\sum^{n}_{j\neq i}\frac{q_j}{r_{ij}}\right)\\
    &=\frac{1}{2}\sum^n_{i=1}\left(q_i\cdot\sum^{n}_{j\neq i}\frac{1}{4\pi\epsilon_0}\cdot\frac{q_j}{r_{ij}}\right)\\
    &=\frac{1}{2}\sum^n_{i=1}q_i\phi_i.
    \end{aligned}
    $$

    其中，$\phi_i$ 是其他点电荷在第 $i$ 个点电荷处的电势和。存在 $\frac{1}{2}$ 的原因是在求和时，每对电荷间的相互作用能被重复考虑了两次。

- **连续分布电荷：**

    对于连续分布电荷的总静电能，根据前面多个点电荷的推导，显然可以过渡到连续形式，

    $$
    \begin{aligned}
    W_e&=\frac{1}{2}\int\phi\mathrm{d}q\\
    &=\frac{1}{2}\iiint\rho_e\phi\mathrm{d}V.
    \end{aligned}
    $$

    从积分角度考虑，此时并没有离散情况下 $j\neq i$ 的条件，因此该总能量是包含了相互作用能和“自能”的，但是在此处连续情况与离散情况的静电能计算是**统一**的，这是通过对点电荷能量特殊的定义(也就是忽视点电荷的自能)来实现的，这根本上来自对于能量的定域与点电荷理想模型的**矛盾**，会在下文阐述。

    **注意**这所谓的静电能是针对一个孤立的带电体系而言，如果存在外电场，则能量关系就纠缠不清了，此时对于需要研究的电荷只能说得清它们在外场中的电势能。所以接下来要引入电场能的概念来把静电学中的**能量**概念阐述清楚。

## 电场能

就目前的学习或者观点，我们会倾向于把静电能量定域在电场中，而不是储存在电荷中，这种说法更接近本质。不过在普物中这是完全不需要关心的，因为普物主要考察的是电荷在外场中的电势能，并且这两种说法基本上只是术语和观察角度的不同，在计算结果上一般不会有区别。
从电场的角度来看静电能，对于一个孤立体系，总静电能
$$
W_e=\frac{\epsilon_0}{2}\iiint_{整个空间}\boldsymbol{E}\cdot\boldsymbol{E}\mathrm{d}V.$$ 其中电场能量密度就是 $$u=\frac{1}{2}\epsilon_0E^2
$$

!!! note "电场能量密度的推导"
    已知两条方程：

    - 静电能方程

    $$
    W_e=\frac{1}{2}\iiint\rho_e\phi\mathrm{d}V
    $$

    - 电荷密度方程

    $$
    \begin{aligned}
    \rho_e&=\epsilon_0\nabla\cdot\boldsymbol{E}=\epsilon_0\nabla\cdot\left(-\nabla\phi\right)\\
    &=-\epsilon_e\nabla^2\phi
    \end{aligned}
    $$

    将第二条方程代入第一条，即可得
    $$
    W_e=-\frac{\epsilon_0}{2}\iiint\phi\nabla^2\phi\mathrm{d}V,
    $$
    使用分部积分做展开

    $$
    \begin{aligned}
    \phi\nabla^2\phi&=\phi\left(\frac{\partial^2\phi}{\partial x}+\frac{\partial^2\phi}{\partial y}+\frac{\partial^2\phi}{\partial z}\right)\\
    &=\frac{\partial}{\partial x}\left(\phi\frac{\partial \phi}{\partial x}\right)-\left(\frac{\partial\phi}{\partial x}\right)^2+\frac{\partial}{\partial y}\left(\phi\frac{\partial \phi}{\partial y}\right)-\left(\frac{\partial\phi}{\partial y}\right)^2+\frac{\partial}{\partial z}\left(\phi\frac{\partial \phi}{\partial z}\right)-\left(\frac{\partial\phi}{\partial z}\right)^2\\
    &=\nabla\cdot(\phi\nabla\phi)-(\nabla\phi)\cdot(\nabla\phi).
    \end{aligned}
    $$

    因此能量积分就为
    $$
    W_e=\frac{\epsilon_0}{2}\iiint(\nabla\phi)\cdot(\nabla\phi)\mathrm{d}V-\frac{\epsilon_0}{2}\iiint\nabla\cdot(\phi\nabla\phi)\mathrm{d}V.
    $$
    利用数学高斯定理，可以将后一个积分转变为面积分
    $$
    \iiint\nabla\cdot(\phi\nabla\phi)\mathrm{d}V=\oiint\phi\nabla\phi\cdot\boldsymbol{n}\mathrm{d}a.
    $$
    假定电荷被约束在有限距离内，将该面积分的高斯面扩展至无穷远(则体积就是对全空间的积分)。取一球面包裹住所有电荷，则 $\phi$ 按 $\frac{1}{r}$ 的速度减小，$\boldsymbol{E}=\nabla\phi$ 按 $\frac{1}{r^2}$ 的速度缩小，而面积 $a$ 按 $r^2$ 的速度增大，则该积分按 $\frac{1}{r}$ 的速度减小，最终会收敛于零。

    因此得到了结果：
    $$
    W_e=\frac{\epsilon_0}{2}\iiint_{全空间}(\nabla\phi)\cdot(\nabla\phi)\mathrm{d}V=\frac{\epsilon_0}{2}\iiint_{全空间}\boldsymbol{E}\cdot\boldsymbol{E}\mathrm{d}V
    $$

## 点电荷的能量

如果把能量定域在电场中，则单个点电荷也会有能量，并且其不存在与其他电荷的相互作用，该能量是他的 **"自能"**。

首先有能量密度
$$
u=\frac{\epsilon_0E^2}{2}=\frac{q^2}{32\pi^2\epsilon_0r^4}
$$
则有总能量
$$
W_e=\int_0^\infty\frac{q^2}{32\pi^2\epsilon_0r^4}\cdot 4\pi r^2\mathrm{d}r=-\frac{q^2}{8\pi\epsilon_0}\left.\frac{1}{r}\right|^{\infty}_0
$$
这显然是发散的。这就说明了把能量定域在电场中的概念与存在点电荷(电子)的假设或者说模型是**相互矛盾**的。一种解决问题的方法是假设电子也依然可以细分成更小的连续分布电荷。另一种可能是，在电子尺度下，经典电学理论已经出现错误。这两种观点都有困难，当然也不必更深入了。
