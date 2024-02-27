# 静电学
## 库仑定律与叠加原理

!!! note 库仑定律
    $$
    \boldsymbol{F_1}=\frac{1}{4\pi\epsilon_0}\frac{q_1q_2}{r_{12}^2}\boldsymbol{e_{21}}=-\boldsymbol{F_2}
    $$
    $\boldsymbol{F_1}$ 是 $q_2$ 作用到 $q_1$ 上的力，$\boldsymbol{e_{21}}$ 是从 $q_2$ 指向 $q_1$ 的单位矢量，$r_{12}$ 是两个点电荷的间距。
    $\epsilon_0$，真空介电常数，测量值为 $8.854\times10^{-12}\rm{C^2/(N\cdot m^2)}$。在之后可以得到 $\epsilon_0=\frac{1}{4\pi c^2}\cdot 10^7$，其中 $c$ 为光速，这是精确的定义。

- **点电荷：** 理想模型，只有电荷量，没有体积。
- **电荷守恒：** 孤立系统总电荷(净电荷)守恒。
- **叠加原理：** 空间存在多个点电荷时，某点电荷受到的静电力等于其它点电荷各自单独存在时静电力的矢量和。
    $$\boldsymbol{F_1}=\sum_{i\neq 1}\frac{1}{4\pi\epsilon_0}\frac{q_1q_i}{r_{1i}^2}\boldsymbol{e_{i1}}$$

## 电场与电势
- **电场：** 
    可以定义为作用在某一点处单位电荷的受力，是矢量。以点电荷为例：$$\boldsymbol{E_1}=\sum_{i\neq 1}\frac{1}{4\pi\epsilon_0}\frac{q_i}{r_{1i}^2}\boldsymbol{e_{i1}}$$
- **电势：**  
    静电场是保守场，也就是说电场的第二类曲线积分与路径无关。对于保守场，都可以定义对应的势能。其物理意义为，将单位电荷从参考点 $P_0$ 移动至 $P$ 时，用于克服保守力所做的功。$$\phi(P)=-\int_{P_0}^P\boldsymbol{E}\cdot \mathrm{d}\boldsymbol{s}$$
    其微分形式就是 $$\boldsymbol{E}=-\nabla\phi=-\left(\frac{\partial \phi}{\partial x}+\frac{\partial \phi}{\partial y}+\frac{\partial \phi}{\partial z}\right).$$
    对于点电荷而言，通常定义无穷远为参考点，其电势分布就为：$$\phi(r)=-\int_\infty^r\frac{1}{4\pi\epsilon_0}\cdot\frac{q}{r^2}\mathrm{d}r=\frac{1}{4\pi\epsilon_0}\frac{q}{r}.$$
## 高斯定律
- **电通量：** 选定曲面 $\Sigma$ 的一侧，电场对于该曲面的第二类曲面积分的值就是在该曲面上的电通量。$$\Phi_E=\iint_\Sigma \boldsymbol{E}\cdot\mathrm{d}\boldsymbol{S}$$

!!! note 高斯定律
    $$
    \oiint_\Sigma \boldsymbol{E}\cdot \mathrm{d}\boldsymbol{S}=\frac{q_{enclosed}}{\epsilon_0}
    $$
    对于一个闭合曲面，曲面定向为外侧，则从该闭合曲面出来的总电通量等于该曲面**内**的总电荷除以真空介电常数。
    
    **高斯定律与库仑定律：** 
    接下来要证明高斯定律与库仑定律(平方反比律)的等价性。我们只需对单一点电荷作出证明，之后根据电场叠加原理和散度的线性性即可推广到多个点电荷和连续分布电荷的情况。
    
    取一个点电荷和任意一个曲面 $\Sigma$，由数学上的高斯公式可知，$$\oiint_\Sigma \boldsymbol{E}\cdot \mathrm{d}\boldsymbol{S}=\iiint_\Sigma \nabla\cdot \boldsymbol{E}\ \mathrm{d}V.$$
    条件是，$\boldsymbol{E}$ 在 $\Sigma$ 内处处可求偏导。
    
    如果 $\Sigma$ 内不包含该点电荷，根据球坐标系散度公式 $$\nabla\cdot\boldsymbol{E}=\frac{1}{4\pi\epsilon_0}\cdot\frac{1}{r^2}\frac{\partial}{\partial r}\left(r^2\cdot\frac{1}{r^2}\right)=0,$$
    因此有，$$\oiint_\Sigma \boldsymbol{E}\cdot \mathrm{d}\boldsymbol{S}=0.$$
    如果 $\Sigma$ 的**内部**包含点电荷，需要绕开 $r=0$ 该点。由于点电荷没有体积，可以取一个半径足够小的球面 $\Sigma'$ 包裹住点电荷，使得球面全部在 $\Sigma$ 内部。
    
    则穿过 $\Sigma'$ 的电通量 $$\oiint_{\Sigma'} \boldsymbol{E}\cdot \mathrm{d}\boldsymbol{S}=\frac{1}{4\pi\epsilon_0}\frac{q}{r^2}\cdot 4\pi r^2=\frac{q}{\epsilon_0},$$
    穿过由 $\Sigma$ 与 $\Sigma'$ 组成的曲面的电通量
    $$
    \begin{aligned}
    \oiint_{\Sigma-\Sigma'} \boldsymbol{E}\cdot \mathrm{d}\boldsymbol{S}&=\oiint_\Sigma \boldsymbol{E}\cdot \mathrm{d}\boldsymbol{S}-\oiint_{\Sigma'} \boldsymbol{E}\cdot \mathrm{d}\boldsymbol{S}\\
    &=\iiint_{\Sigma-\Sigma'}\nabla\cdot\boldsymbol{E}\ \mathrm{d}V\\
    &=0,
    \end{aligned}
    $$
    可以推出 $$\oiint_\Sigma \boldsymbol{E}\cdot \mathrm{d}\boldsymbol{S}=\oiint_{\Sigma'} \boldsymbol{E}\cdot \mathrm{d}\boldsymbol{S}=\frac{q}{\epsilon_0}.$$
    这就是根据库仑定律数学推导出高斯定律。直观推导先放放。
    
    又由于 $q=\iiint_\Sigma\rho_e\mathrm{d}V$，结合以上推导可以得到$$\nabla\cdot\boldsymbol{E}=\frac{\rho_e}{\epsilon_0},$$
    $\rho_e$ 是该点的体电荷密度。这是高斯定律的微分形式，也是麦克斯韦方程组的第一条方程。

# 高斯定律的应用与经典静电场模型
## 线电荷、面电荷与体电荷
### 线电荷
- **无限长均匀线电荷**
    设线电荷密度为 $\lambda$，取如图所示的圆柱形高斯面，则有，$$E_r\cdot 2\pi rh=\frac{\lambda\cdot h}{\epsilon_0}.$$ 即可得到径向电场 $$E_r=\frac{\lambda}{2\pi\epsilon_0 r}.$$
    ![无限长](infinite_line.png)
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
    ![有限长](finite_line.png)

### 面电荷；平行板
- **无限大面电荷**
    由于对称，两侧电场大小相同，方向垂直于电荷平面。设面电荷密度为 $\sigma$， 应用高斯定理可得 $$E=\frac{\sigma}{2\epsilon_0}.$$
- **两块平行板间电场**
    叠加或者高斯定理均可得到 $$E=\frac{\sigma}{\epsilon_0}.$$

![面电荷](sheet.png)

### 球体；球壳
对于一个均匀分布有体电荷密度 $\rho$ 的球体，取一个球面作为高斯面，易得电场分布为
$$
E=\left\{
\begin{aligned}
&\frac{\rho r}{3\epsilon_0}&r<R\\
&\frac{\rho R^3}{3\epsilon_0r^2}&r\ge R
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

## *电偶极子
取相距为 $l$ 的两个点电荷 $+q$ 与 $-q$。使用极坐标系，令极轴沿这两电荷的连线，并选取原点在其中间。可以得到电荷的电势为 $$\phi(r,\theta)=\frac{1}{4\pi\epsilon_0}\left(\frac{q}{\sqrt{r^2+(l/2)^2-rl\cos\theta}}+\frac{-q}{\sqrt{r^2+(l/2)^2+rl\cos\theta}}\right).$$
![偶极子](dipole.png)

通常而言，我们会研究那些距离远大于电荷间距处的的电场，即 $r\gg l$，则泰勒展开化简得到电势 $$\phi(r,\theta)=\frac{1}{4\pi\epsilon_0}\frac{p\cos\theta}{r^2},$$
式中 $p=ql$，其被定义为电偶极矩。
应用极坐标梯度公式可以得到径向与切向电场
$$
\begin{aligned}
\boldsymbol{E}&=-\nabla\phi\\
&=-\left(\frac{\partial\phi}{\partial r}\boldsymbol{e_r}+\frac{1}{r}\frac{\partial\phi}{\partial\theta}\boldsymbol{e_\theta}\right)\\
&=\frac{1}{4\pi\epsilon_0}\frac{p\cos\theta}{r^3}\boldsymbol{e_r}+\frac{1}{4\pi\epsilon_0}\frac{p\sin\theta}{r^3}\boldsymbol{e_\theta}.
\end{aligned}
$$

## *电像法
电像法是一种通过等效替代在实空间达到相同电势电场分布的思维与解题方法，它的理论根据是唯一性定理(不做证明)。*普物课程里应当不会讲这种方法，但是在某些考试题目中偶尔会涉及到*，因此姑且讲解两个最基础的模型应付考试即可。
- **点电荷与无穷大导体板**
![the method of images](ImageMethod.png)
在一接地无穷大导体平板上方有一点电荷 $q$，则在实空间(点电荷 $q$ 一侧的空间)的电场电势分布等效于有一个镜像电荷 $-q$ 在对称位置，这一对电荷的电场电势分布。$q$ 受到的力就是 $-q$ 对它产生的电场力。像空间(点电荷 $q$ 对侧的空间)的电场由于静电屏蔽，实际为零。
- **点电荷与导体球**
![the method of images II](ImageMethod2.png)
一接地导体球外侧有一点电荷 $q$。电像法实际是模拟相同的电势分布，只要满足镜像电荷与原电荷的等势面恰是该导体球面的形状即可。
假设有一个镜像点电荷在球内，由于导体球电势为零，若满足 $\frac{q}{r_1}+\frac{q'}{r_2}=0$，则这是一个阿波罗尼乌斯圆。调整参数大小使得球心离 $q$ 恰为 $b$，半径恰为 $a$，有镜像电荷 $q'=-\frac{a}{b}q$，离球心距离 $d=\frac{a^2}{b}$。
**注意：**
    - 电场分布与电势分布仅在球外的区域成立，球内均为零。
    - 如果导体球不接地，比如原本带有电荷 $Q$，则除去镜像电荷 $q'$ 后， 在球心额外有一个电荷 $q''=Q-q'=Q+\frac{a}{b}q$，如此不改变球面等势，也没有改变电荷总量，可以作为等效电荷分布。

# *静电能
## 电荷的静电能
- **两个点电荷：**
    根据先前对点电荷电势的推导，可知将这两个点电荷从相距无穷远移动到相距 $r_{12}$，所要做的功为 $$\frac{q_1q_2}{4\pi\epsilon_0r_{12}},$$ 这对电荷的**相互作用能**就为该值。由之后的推导可知，由于点电荷模型的特殊性，点电荷的自能发散，则这个电荷体系的总能量，也就是我们所说的**静电能**(包含自能与相互作用能，不过事实上**不用把自能和相互作用能这二者区分的十分清楚**)，就可以用这个值表征,即 $$U_{12}=\frac{q_1q_2}{4\pi\epsilon_0r_{12}}.$$
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
    从积分角度考虑，此时并没有离散情况下 $j\neq i$ 的条件，因此该总能量是包含了相互作用能和“自能”的，但是在此处连续情况与离散情况的静电能计算是**统一**的，这是通过对点电荷能量特殊的定义(也就是忽视点电荷的自能)来实现的，这个矛盾根本上来自对于能量的定域与点电荷理想模型的矛盾，这会在下文阐述。
    **注意**这所谓的静电能是针对一个孤立的带电体系而言，如果存在外电场，则能量关系就纠缠不清了，此时对于需要研究的电荷只能说得清它们在外场中的电势能。所以接下来要引入电场能的概念来把静电学中的**能量**概念阐述清楚。

## 电场能
就目前的学习或者观点，我们会倾向于把静电能量定域在电场中，而不是储存在电荷中，这种说法更接近本质。不过在普物中这是完全不需要忧心的，因为其主要考察的是电荷在外场中的电势能，并且这两种说法基本上只是术语和观察角度的不同，在计算结果上一般不会有区别。
从电场的角度来看静电能，对于一个孤立体系，总静电能 $$U=\frac{\epsilon_0}{2}\iiint_{整个空间}\boldsymbol{E}\cdot\boldsymbol{E}\mathrm{d}V.$$ 其中电场能量密度就是 $$u=\frac{1}{2}\epsilon_0E^2$$


# 电容器与电介质

# 稳恒电流

# 静磁学

# 电磁感应

# 麦克斯韦方程组

# 电磁波