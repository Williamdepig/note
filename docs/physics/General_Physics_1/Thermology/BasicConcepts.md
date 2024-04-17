# 热学基本概念

!!! info
    我们不从无趣的温标、热传导、热膨胀开讲，而先讲气体的分子动理论，也就是从力学推导到热学的统计规律，以及理想气体状态方程、能量均分等等。

## 气体分子动理论

### 压强

<p>
<img src="/assets/images/physics/General_Physics_1/Thermology/pressure.png" alt="pressure" style="float:right" width="200" > 设想一个充满气体的容器，一端是可以无摩擦移动的活塞，求分子运动对于活塞产生的平均的力。先定义压强
</p>

**压强** $ \quad $ 加在活塞上的力与活塞面积之比。$$ P=\frac{F}{A} $$

从经典力学角度考虑压强的微观本质。假定分子与活塞之间是弹碰，分子速度为 $\boldsymbol{v}$，其 $x$ 向分量为 $v_x$。则分子与活塞的一次碰撞施加给活塞的动量为 $2mv_x$。

接下来只需知道单位时间内会与活塞发生碰撞的分子数即可。设单位体积内的分子数为 $n=N/V$。注意到，在时间 $t$ 内，对于速度为 $v_x$ 的分子，只要其离活塞的距离在 $v_xt$ 以内，就会撞上活塞，则分子数就为 $n\cdot v_xtA$，求单位时间就是 $nv_xA$。

这样就求得力为 $$ F=nv_xA\cdot 2mv_x. $$
压强为 $$ P=2nmv_x^2. $$
当然，由于不同分子 $x$ 向速度不会完全相同，并且由于有了平方，公式中也会把 $v_x<0$ 的部分算上。则有压强 $$ P=nm\langle v_x^2 \rangle. $$
由于分子平动的对称性 $$ \langle v_x^2 \rangle = \langle v_y^2 \rangle = \langle v_z^2 \rangle = \frac{\langle v^2\rangle}{3}. $$
于是就有压强公式 $$ P=\left( \frac{2}{3}\right)n\left\langle \frac{mv^2}{2}\right\rangle. $$
定义气体内能就是总分子数乘每个分子的平均动能，如果分子没有转动与振动自由度，则就为平动动能，有 $$ PV=\frac{2}{3}U. $$
之后的推导就在热一定律中见吧。

### 温度与动能

<p>
<img src="/assets/images/physics/General_Physics_1/Thermology/collision.png" alt="pressure" style="float:right" width="150" > 我们希望了解气体处于“平衡态”时的微观本质。
</p>

假设气体中存在两种分子，在质心系中考虑二者的碰撞。显然碰撞前后速率不变，仅方向改变。最终平衡时的分布为：**任何一对分子沿空间任何方向的运动是等可能的**。也就是说，两个分子运动方向随机且相互独立。

碰撞前后不改变这种分布，即在质心系中，分子从单位立体角射出的概率相等。回归实验系，这个条件的数学描述就为：**两个分子的相对速度与质心速度相互独立**。$$ \langle \boldsymbol{w}\cdot \boldsymbol{v_{\tiny CM}} \rangle = 0. $$
设两分子在实验系中的速度为 $\boldsymbol{v_1}$ 与 $\boldsymbol{v_2}$，有

$$
\begin{aligned}
    \boldsymbol{w}\cdot \boldsymbol{v_{\tiny CM}} &= \frac{(\boldsymbol{v_1}-\boldsymbol{v_2})\cdot(m_1\boldsymbol{v_1}+m_2\boldsymbol{v_2})}{m_1+m_2}\\
    &= \frac{(m_1v_1^2-m_2v_2^2)+(m_2-m_1)(\boldsymbol{v_1}\cdot\boldsymbol{v_2})}{m_1+m_2}.
\end{aligned}
$$

显然，$\boldsymbol{v_1}$ 与 $\boldsymbol{v_2}$ 相互独立，有 $$ \langle \boldsymbol{v_1\cdot v_2}\rangle = \langle \boldsymbol{v_1}\rangle\cdot \langle \boldsymbol{v_2}\rangle =0,$$
再由前述条件，最终发现平衡态条件即为：**不同气体分子质心运动的平均动能相等**。 $$ \frac{1}{2}m_1v_1^2=\frac{1}{2}m_2v_2^2. $$
因此为了表征分子的这种特性，可以用分子平均动能的函数来定义温度，当然线性关系即可，但还要乘以玻尔兹曼常数 $k=\frac{R}{N_A}=1.381\times 10^{-23}\mathrm{J/K}$，即
**温度** $ \quad $ 表征分子运动的能量。 $$ \frac{1}{2}\langle mv^2\rangle=\frac{3}{2}kT. $$
 
系数是为方便而引入的。当然 3 这个系数似乎恰对应平动的 3 个自由度，这件事需要在能量均分章节中作出阐述。

### 理想气体状态方程

将温度的定义带入气压方程可得 $$ P=nkT, $$
或者 $$ PV=NkT. $$
也就是说在等温等压等容的情况下，原子数确定，这就是阿伏伽德罗常数的理论由来，可以把这个方程写成另一个更常见的形式 $$ PV=\nu RT. $$
其中 $\nu$ 为物质的量， $R=8.314\mathrm{J/(mol\cdot K)}$ 为理想气体常数。这样我们就推出了理想气体状态方程。

前文的叙述似乎仅针对单原子分子的情况，但还有一点需要证明，即对于多原子分子，理想气体状态方程依然成立。首先，只需将压强公式中的 $v$ 改为分子质心速度 $v_{\tiny CM}$，这不会改变任何东西；其次，只需证明质心平动动能 $\frac{1}{2}Mv_{\tiny CM}^2$ 依然等于 $\frac{3}{2}kT$ 即可。

$$
\begin{aligned}
v_{\tiny CM}^2 &= \frac{\left(\sum\limits_{i=1}^n m_i\boldsymbol{v_i}\right)^2}{M^2}\\
&= \frac{\sum m_i^2v_i^2}{M^2}+\frac{\sum\limits_{i\neq j}m_im_j(\boldsymbol{v_i\cdot v_j})}{M^2}\\
&= \frac{3kT}{M}+\frac{\sum\limits_{i\neq j}m_im_j\langle\boldsymbol{v_i\cdot v_j}\rangle}{M^2}
\end{aligned}
$$

式中用了 $\frac{1}{2}\langle m_iv_i^2\rangle=\frac{3}{2}kT$ 的条件。因此只需证明 $\langle\boldsymbol{v_i\cdot v_j}\rangle=0$ 即可。

接着从相对速度入手,不妨取原子 1 和 原子 2，有

$$
\begin{aligned}
\boldsymbol{w\cdot v_{\tiny CM}}&=\frac{m_Av_A^2-m_Bv_B^2+(m_2-m_1)\langle\boldsymbol{v_1\cdot v_2}\rangle+(\boldsymbol{v_1}-\boldsymbol{v_2})\cdot(\sum\limits_{i=3}^n m_i\boldsymbol{v_i})}{M}\\
&=0 
\end{aligned}
$$

第一项显然为零。第三项，原子 1 和原子 2 的相对运动在任意方向分解的平均值自然都是零。因此可得 $$ (m_i-m_j)\langle\boldsymbol{v_i\cdot v_j}\rangle=0, $$
最终推出 $$ \frac{1}{2}Mv_{\tiny CM}^2=\frac{3}{2}kT. $$
则可得理想气体状态方程“普适”成立。

当然，你会疑惑那么多分子的能量怎么会仅仅如此，每个分子都有三个平动自由度，那剩下的 $\frac{3(n-1)}{2}kT$ 去哪了。其实这些都是分子内部运动的能量，也就是振动与转动动能。下一节就要介绍，不论平动、振动还是转动，每个自由度对应的平均能量均为 $\frac{1}{2}kT$，也即能量均分定理。

### 能量均分

从前面的小节中相信你能大致明白自由度和能量均分是啥东西，接下来需要做些定量的讨论。

可以发现，平动动能 $\frac{1}{2}mv^2$、转动动能 $\frac{1}{2}I\omega^2$、振动势能 $\frac{1}{2}kx^2$ 其实拥有相同的形式，后面第二章分布律章节能表明，这样的形式会导出相同的麦克斯韦分布形式，即 $$ f_M(v)=\sqrt{\frac{m}{2\pi kT}}\mathrm{e}^{-\frac{mv^2}{2kT}} $$
仅仅用不同的系数和变量名代替罢了，因此根据高斯积分公式，可以得到平方平均值
$$ \frac{1}{2}m\langle v^2 \rangle = \frac{1}{2}m \int_{-\infty}^{\infty}v^2f_M(v)\mathrm{d}v=\frac{1}{2}kT $$
这就是能量均分定理：**每个自由度的能量均值都等于 $\frac{1}{2}kT$**。当然需要说明的是，如果把振动简化为简谐振动，则其振动动能与势能相等，因此一个振动自由度实则对应 $kT$ 的能量。

### 状态数有限性
