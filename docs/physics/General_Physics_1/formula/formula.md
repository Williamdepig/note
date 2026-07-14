# 普物Ⅰ公式汇总

## 基础数学知识

1. 矢量运算：$ \boldsymbol{a}=(a_x,a_y,a_z),\boldsymbol{b}=(b_x,b_y,b_z). $
    - 叉积：

    $$ \boldsymbol{a} \times \boldsymbol{b} = \begin{vmatrix} \boldsymbol{i} & \boldsymbol{j} & \boldsymbol{k} \\ a_x & a_y & a_z \\ b_x & b_y & b_z \end{vmatrix} $$

    - 点积：$$ \boldsymbol{a} \cdot \boldsymbol{b} = a_x b_x + a_y b_y + a_z b_z $$
    - 三重标积： $$ \boldsymbol{a} \cdot (\boldsymbol{b} \times \boldsymbol{c}) = \boldsymbol{b} \cdot (\boldsymbol{c} \times \boldsymbol{a}) = \boldsymbol{c} \cdot (\boldsymbol{a} \times \boldsymbol{b}) $$
    - 三重矢积： $$ \boldsymbol{a} \times (\boldsymbol{b} \times \boldsymbol{c}) = (\boldsymbol{a} \cdot \boldsymbol{c})\boldsymbol{b} - (\boldsymbol{a} \cdot \boldsymbol{b})\boldsymbol{c} $$

2. 泰勒展开：$$ f(x) = f(a) + f'(a)(x-a) + \frac{f''(a)}{2!}(x-a)^2 + \cdots + \frac{f^{(n)}(a)}{n!}(x-a)^n + \cdots $$

3. 线性方程组：

$$
\begin{cases} a_{11}x_1 + a_{12}x_2 + \cdots + a_{1n}x_n = b_1 \\ a_{21}x_1 + a_{22}x_2 + \cdots + a_{2n}x_n = b_2 \\ \cdots \\ a_{n1}x_1 + a_{n2}x_2 + \cdots + a_{nn}x_n = b_n \end{cases} 
$$

有根条件为久期方程：

$$
\begin{vmatrix} a_{11} &... &a_{1n}\\... & &\\a_{n1} &... &a_{nn} \end{vmatrix}=0
$$

4. 高斯积分：

$$
\begin{equation*}
\begin{aligned}
I_0&=\int_0^\infty e^{-ax^2}\mathrm{d}x=\frac{1}{2}\sqrt{\frac{\pi}{a}}\\
I_1&=\int_0^\infty xe^{-ax^2}\mathrm{d}x=\frac{1}{2a}\\
...\\
I_{2n}&=\int_0^\infty x^{2n}e^{-ax^2}=(-1)^n\frac{\mathrm{d}^n}{\mathrm{d}a^n}I_0\\
I_{2n+1}&=\int_0^\infty x^{2n+1}e^{-ax^2}=(-1)^n\frac{\mathrm{d}^n}{\mathrm{d}a^n}I_1
\end{aligned}
\end{equation*}
$$

## 力学

不是很想列力学的公式，因为都太基础了.

1. 运动学：你懂的.
2. 牛顿三定律：你懂的.
3. 伽利略相对性原理：经典力学定律在任何惯性参考系中数学形式不变.
4. 惯性力
5. 动量定理
6. 变质量物体运动方程：$$ F=\frac{\mathrm{d}(mv)}{\mathrm{d}t} =v\frac{\mathrm{d}m}{\mathrm{t}}+ma$$
7. 碰撞恢复系数：$$ e = \frac{v_{2n}'-v_{1n}'}{v_{1n}-v_{2n}} $$
8. 能量守恒、机械能守恒
9. 质点角动量：$$ \boldsymbol{L} = \boldsymbol{r} \times \boldsymbol{p} $$
力矩：$$ \boldsymbol{M} = \boldsymbol{r} \times \boldsymbol{F} $$
10. 质点系转动惯量：

$$
\begin{equation*}
\begin{aligned}
\hat{I} &= \begin{pmatrix}
I_{xx} & I_{xy} & I_{xz} \\
I_{yx} & I_{yy} & I_{yz} \\
I_{zx} & I_{zy} & I_{zz}
\end{pmatrix}\\
I_{xx} &= \int(y^2+z^2)\mathrm{d}m\\
I_{yy} &= \int(x^2+z^2)\mathrm{d}m\\
I_{zz} &= \int(x^2+y^2)\mathrm{d}m\\
I_o &= \int r^2\mathrm{d}m = \int (x^2+y^2+z^2)\mathrm{d}m\\
2I_o &= I_{xx}+I_{yy}+I_{zz}\\
...
\end{aligned}
\end{equation*}
$$

11. 质点系角动量：$$ \boldsymbol{L} = \hat{I}\boldsymbol{\omega} $$
12. 转动定律：$$ \boldsymbol{M} = \frac{\mathrm{d}\boldsymbol{L}}{\mathrm{d}t}=\hat{I}\boldsymbol{\beta} $$
13. 万有引力定律：$$ \boldsymbol{F} = -\frac{Gm_1m_2}{r^2}\boldsymbol{e_r} $$
14. 引力势能（无穷远为零点）：$$ V = -\frac{Gm_1m_2}{r} $$
15. 简谐振子：$$ m\frac{\mathrm{d}^2x}{\mathrm{d}t^2} = -kx $$

- 能量：$$ E=\frac{1}{2}mv^2+\frac{1}{2}kx^2=\frac{1}{2}m\dot{x}^2+U(x) $$
- 振动角频率：$$ \omega = \sqrt{\frac{k}{m}}=\sqrt{\frac{U''(x_0)}{m}} $$

16. 阻尼振动：$$ \ddot{x}+2\Omega\dot{x}+\omega_0^2 x=0 $$
解为 $$ x(t) = Ae^{-\Omega t}e^{i\omega t} $$
其中 $$ \omega = \sqrt{\omega_0^2-\Omega^2} $$
17. 波动方程：$$ \frac{\partial^2u}{\partial t^2} = v^2\frac{\partial^2u}{\partial x^2} $$

- 正弦波：$$ u(x,t) = A\sin(kx-\omega t+\varphi) $$
- 角频率：$$ \omega = 2\pi f $$
- 波数：$$ k = \frac{2\pi}{\lambda} $$
- 波速：$$ v = \frac{\omega}{k}=\lambda f $$

18. 弦上波速：$$ v = \sqrt{\frac{T}{\mu}} $$
19. 波能量密度：$$ \varepsilon=\frac{1}{2}\rho \omega^2 y_m^2 $$
能流密度：$$ \boldsymbol{i}=\varepsilon \boldsymbol{v}=\frac{1}{2}\rho\omega^2 y_m^2 \boldsymbol{v} $$
20. 驻波条件：$$ \lambda_n=\frac{2L}{n} $$
21. 多普勒效应：$$ f = f_0\frac{v\pm v_s}{v\pm v_o} $$

## 相对论

1. 相对性原理：在所有惯性系中，物理学定律的形式都是相同的.
2. 光速不变原理：光在真空中的传播速度是一个恒定值，与光源或观察者的运动状态无关.
3. 相关符号：$$ \beta=\frac{v}{c},\gamma=\frac{1}{\sqrt{1-\beta^2}},s=\sqrt{1-\beta^2} $$
4. 洛伦兹变换：$$ t = \gamma(t' + \frac{\beta x'}{c}),x = \gamma(x' + \beta ct'),y = y',z = z' $$
5. 尺缩：$$ L = L_0/\gamma $$
钟慢：$$ T = \gamma T_0 $$
6. 时空间隔：$$ s_0^2 = -c^2t^2 + x^2 + y^2 + z^2 $$
7. 速度变换：$$ u_x = \frac{u_x' + v}{1 + \frac{\beta}{c}u_x'},u_y=\frac{u_y'}{\gamma(1 + \frac{\beta}{c}u_x')},u_z=\frac{u_z'}{\gamma(1 + \frac{\beta}{c}u_x')} $$
8. 多普勒效应：$$ f = f_0\frac{\sqrt{1-\beta^2}}{1-\beta\cos\theta} $$
9. 相对论能动量变换：$$ E=\gamma(E'+\beta p_x'c), p_x=\gamma(p_x'+\frac{\beta}{c}E'),p_y=p_y',p_z=p_z'$$
10. 动质量：$$ m = \gamma m_0 $$
总能量：$$ E = mc^2 =\gamma m_0c^2 $$
动量：$$ \boldsymbol{p} = m\boldsymbol{v} = \gamma m_0\boldsymbol{v} $$
能量-动量关系：$$ E^2 = (pc)^2 + (m_0c^2)^2 $$
11. 相对论牛二定律：$$ \boldsymbol{F} = \frac{\mathrm{d}\boldsymbol{p}}{\mathrm{d}t} $$

## 热学

1. 相关常数：

   - 气体常数：$ R = 8.31\,J/(mol\cdot K) $
   - 玻尔兹曼常数：$ k =\frac{R}{N_A}= 1.38\times 10^{-23}\,J/K $
   - 阿伏伽德罗常数：$ N_A = 6.02\times 10^{23}\,mol^{-1} $

2. 线胀系数（linear expansion）：$$ \alpha = \frac{1}{L}\frac{\Delta L}{\Delta T} $$
体膨胀系数（volume expansion）：$$ \beta = \frac{1}{V}\frac{\Delta V}{\Delta T} $$
线胀系数与体膨胀系数的关系：$$ \beta = 3\alpha $$
3. 一维热传导方程：$$ \frac{\mathrm{d}Q}{\mathrm{d}t}=-\kappa_t S \frac{\mathrm{d}T}{\mathrm{d}x} $$
4. 理想气体状态方程：$$ PV = nRT $$
5. 范德瓦尔斯（Van der Waals）方程：$$ (P+\frac{an^2}{V^2})(V-nb) = nRT $$
临界状态：$$ P_c = \frac{a}{27b^2},V_c = 3n_cb,T_c = \frac{8a}{27bR} $$
6. 麦克斯韦速率分布：$$ f(v) = 4\pi\left(\frac{m}{2\pi kT}\right)^{\frac{3}{2}}v^2e^{-\frac{mv^2}{2kT}} $$

- 最概然速率（most probable speed）：$$ \frac{\mathrm{d}f(v)}{\mathrm{d}v}=0\Rightarrow v_p = \sqrt{\frac{2kT}{m}} $$
- 平均速率（average speed）：$$ \bar{v} = \int_0^\infty vf(v)\mathrm{d}v = \sqrt{\frac{8kT}{\pi m}} $$
- 均方根速率（root mean square speed）：$$ v_{rms} = \sqrt{\int_0^\infty v^2f(v)\mathrm{d}v} =\sqrt{\frac{3kT}{m}} $$

6. 热力学第一定律：$$\mathrm{d}Q=\mathrm{d}U+\mathrm{d}W $$
准静态过程：$$ \mathrm{d}Q = \mathrm{d}U+p\mathrm{d}V $$
7. 热容量：$$ C = \frac{\mathrm{d}Q}{\mathrm{d}T} $$
内能为分子动能、分子内势能与分子间势能之和，对于理想气体，没有分子间势能，内能仅与温度相关.

以下只适用于理想气体：

- 等容（isovolumetric）热容量：$$ C_V = \frac{\mathrm{d}U(T)}{\mathrm{d}T} $$
- 等压（isobaric）热容量：$$ C_p = \left(\frac{\partial (U+pV)}{\partial T}\right)_P=C_V+R $$

8. 绝热（adiabatic）方程：$$ pV^\gamma = const,\, TV^{\gamma-1}=const,\, pT^{\frac{\gamma}{1-\gamma}}=const $$
9. 热机效率：$$ \eta =\frac{W}{Q_h} = 1-\frac{Q_c}{Q_h}$$
制冷机效率：$$ \eta = \frac{Q_c}{W} $$
卡诺热机：$$ \eta_{car} = 1-\frac{T_c}{T_h} $$
卡诺制冷机：$$ \eta_{car} = \frac{T_c}{T_h-T_c} $$
10. 熵：$$ \mathrm{d}S = \frac{\mathrm{d}Q}{T} $$
11. 信息熵：$$ H(x) = -\sum_1^n p(x_i)\log_2p(x_i) $$ 其中 $ p(x_i) $ 为状态 $ x_i $ 出现的概率.
12. 平均碰撞次数：$$ \bar{Z} = \sqrt{2}\pi nd^2 \bar{v} $$
平均自由程：$$ \bar{\lambda} = \frac{1}{\sqrt{2}\pi nd^2 } $$
$ n $ 为分子数密度，$ d $ 为分子直径.
