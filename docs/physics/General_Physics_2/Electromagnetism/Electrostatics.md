---
counter: True
comment: True
---

# 静电学

## 库仑定律与叠加原理

!!! note "库仑定律"

    $$
    \boldsymbol{F_1}=\frac{1}{4\pi\epsilon_0}\frac{q_1q_2}{r_{12}^2}\boldsymbol{e_{21}}=-\boldsymbol{F_2}
    $$

    $\boldsymbol{F_1}$ 是 $q_2$ 作用到 $q_1$ 上的力，$\boldsymbol{e_{21}}$ 是从 $q_2$ 指向 $q_1$ 的单位矢量，$r_{12}$ 是两个点电荷的间距。

    $\epsilon_0$，真空介电常数，测量值为 $8.854\times10^{-12}\rm{C^2/(N\cdot m^2)}$。后面会说明 $\epsilon_0=\frac{1}{4\pi c^2}\cdot 10^7$，其中 $c$ 为光速，这是精确的定义。

- **点电荷：** 理想模型，只有电荷量，没有体积。
- **电荷守恒：** 孤立系统总电荷(净电荷)守恒。
- **叠加原理：** 空间存在多个点电荷时，某点电荷受到的静电力等于其它点电荷各自单独存在时静电力的矢量和。
    $$
    \boldsymbol{F_1}=\sum_{i\neq 1}\frac{1}{4\pi\epsilon_0}\frac{q_1q_i}{r_{1i}^2}\boldsymbol{e_{i1}}
    $$

## 电场与电势

- **电场：**

    可以定义为作用在某一点处单位电荷的受力，是矢量。以点电荷为例：
    $$
    \boldsymbol{E_1}=\sum_{i\neq 1}\frac{1}{4\pi\epsilon_0}\frac{q_i}{r_{1i}^2}\boldsymbol{e_{i1}}
    $$

- **电势：**

    静电场是保守场，也就是说电场的第二类曲线积分与路径无关。对于保守场，都可以定义对应的势能。其物理意义为，将单位电荷从参考点 $P_0$ 移动至 $P$ 时，用于克服保守力所做的功。

    $$  
    \phi(P)=-\int_{P_0}^P\boldsymbol{E}\cdot \mathrm{d}\boldsymbol{s}
    $$

    其微分形式就是
    $$
    \boldsymbol{E}=-\nabla\phi=-\left(\frac{\partial \phi}{\partial x}+\frac{\partial \phi}{\partial y}+\frac{\partial \phi}{\partial z}\right).
    $$
    对于点电荷而言，通常定义无穷远为参考点，其电势分布就为

    $$
    \phi(r)=-\int_\infty^r\frac{1}{4\pi\epsilon_0}\cdot\frac{q}{r^2}\mathrm{d}r=\frac{1}{4\pi\epsilon_0}\frac{q}{r}.
    $$

## 高斯定律

- **电通量：** 选定曲面 $\Sigma$ 的一侧，电场对于该曲面的第二类曲面积分的值就是在该曲面上的电通量。
    $$
    \Phi_E=\iint_\Sigma \boldsymbol{E}\cdot\mathrm{d}\boldsymbol{S}
    $$

!!! note "高斯定律"

    $$
    \oiint_\Sigma \boldsymbol{E}\cdot \mathrm{d}\boldsymbol{S}=\frac{q_{enclosed}}{\epsilon_0}
    $$

    对于一个闭合曲面，曲面定向为外侧，则从该闭合曲面出来的总电通量等于该曲面**内**的总电荷除以真空介电常数。
    
    **高斯定律与库仑定律：** 

    接下来要证明高斯定律与库仑定律(平方反比律)的等价性。我们只需对单一点电荷作出证明，之后根据电场叠加原理和散度的线性性即可推广到多个点电荷和连续分布电荷的情况。
    
    取一个点电荷和任意一个曲面 $\Sigma$，由数学上的高斯公式可知，
    $$
    \oiint_\Sigma \boldsymbol{E}\cdot \mathrm{d}\boldsymbol{S}=\iiint_\Sigma \nabla\cdot \boldsymbol{E}\ \mathrm{d}V.
    $$
    条件是，$\boldsymbol{E}$ 在 $\Sigma$ 内处处可求偏导。
    
    如果 $\Sigma$ 内不包含该点电荷，根据球坐标系散度公式

    $$
    \nabla\cdot\boldsymbol{E}=\frac{1}{4\pi\epsilon_0}\cdot\frac{1}{r^2}\frac{\partial}{\partial r}\left(r^2\cdot\frac{1}{r^2}\right)=0,
    $$

    因此有，
    $$
    \oiint_\Sigma \boldsymbol{E}\cdot \mathrm{d}\boldsymbol{S}=0.
    $$
    如果 $\Sigma$ 的**内部**包含点电荷，需要绕开 $r=0$ 该点。由于点电荷没有体积，可以取一个半径足够小的球面 $\Sigma'$ 包裹住点电荷，使得球面全部在 $\Sigma$ 内部。
    
    则穿过 $\Sigma'$ 的电通量 
    $$
    \oiint_{\Sigma'} \boldsymbol{E}\cdot \mathrm{d}\boldsymbol{S}=\frac{1}{4\pi\epsilon_0}\frac{q}{r^2}\cdot 4\pi r^2=\frac{q}{\epsilon_0},
    $$
    穿过由 $\Sigma$ 与 $\Sigma'$ 组成的曲面的电通量
    $$
    \begin{aligned}
    \oiint_{\Sigma-\Sigma'} \boldsymbol{E}\cdot \mathrm{d}\boldsymbol{S}&=\oiint_\Sigma \boldsymbol{E}\cdot \mathrm{d}\boldsymbol{S}-\oiint_{\Sigma'} \boldsymbol{E}\cdot \mathrm{d}\boldsymbol{S}\\
    &=\iiint_{\Sigma-\Sigma'}\nabla\cdot\boldsymbol{E}\ \mathrm{d}V\\
    &=0,
    \end{aligned}
    $$
    可以推出 
    $$
    \oiint_\Sigma \boldsymbol{E}\cdot \mathrm{d}\boldsymbol{S}=\oiint_{\Sigma'} \boldsymbol{E}\cdot \mathrm{d}\boldsymbol{S}=\frac{q}{\epsilon_0}.
    $$
    这就是根据库仑定律数学推导出高斯定律。*直观推导先放放。*
    
    又由于 $q=\iiint_\Sigma\rho_e\mathrm{d}V$，结合以上推导可以得到
    $$
    \nabla\cdot\boldsymbol{E}=\frac{\rho_e}{\epsilon_0}.
    $$
    $\rho_e$ 是该点的体电荷密度。这是高斯定律的微分形式，也是麦克斯韦方程组的第一条方程。
