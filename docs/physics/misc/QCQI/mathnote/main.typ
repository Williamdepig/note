#import "@local/mathnote:0.1.0": *
#import "@preview/ilm:1.4.1": *
#import "@preview/physica:0.9.6": *

#show: ilm.with(
  title: [Quantum Computation and Quantum Information],
  author: "Michael A. Nielsen, Isaac L. Chuang",
  // date: datetime(year: 2025, month: 08, day: 08),
  date: datetime.today(),
  abstract: [
    Note by Williamdepig
  ],
  // preface: [
  //   #align(center + horizon)[
  //     Thank you for using this template #emoji.heart,\ I hope you like it #emoji.face.smile
  //   ]
  // ],
  bibliography: bibliography("refs.bib", style: "ieee"),
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


1. 对于可观测量 $ar(v)dot ar(sigma)$，其有特征值 $lambda=plus.minus 1$，对应特征空间的投影算子为 $P_plus.minus = (I plus.minus arrow(v) dot arrow(sigma))\/2$
2. qubit 的书写形式是大端序，如 $ket(001)$ 就表达比特 1 而非 100。


= Quantum Computation
== Quantum circuits

1. 泰勒展开容易证明：$ exp(i A x)=cos(x)I+i sin(x)A $
2. 在 Bloch 球中，绕 $hat(n)=(n_x,n_y,n_z)$ 旋转 $theta$ 角可以写为 $R_(hat(n))(theta)=exp(-i theta space hat(n)dot arrow(sigma) \/ 2)$。
3. 任意的单比特酉变换可以写为 $U=exp(i al)R_(hat(n))(theta)$ 的形式。证明：
  1. 先证明对于 $U in SU(2)$，证明 $U=x_0 I + i(ar(x)dot ar(sigma)), x_0^2 + ar(x)dot ar(x)=1$，则可以写为 $U=cos(theta\/2)I-i sin(theta\/2)hat(n)dot ar(sigma)=R_hat(n)(theta).$
  2. 然后推广到 $U(2)$，$U=e^(i al)V, V in SU(2)$，则就有 $U=e^(i al)R_hat(n)(tht).$
4. (*Z-Y decomposition for a single qubit*) 任意单比特酉变换可以写为 $U=exp(i al)R_Z (beta)R_Y (gamma)R_Z (delta)$ 的形式，证明：
  1. 根据 $U U^dagger = U^dagger U = I$，解 $U=mat(a e^(i al_0), b e^(i beta_0); c e^(i gamma_0), d e^(i delta_0))$，得到系数可以写为上述形式（解方程过程中基本不用考虑符号问题，可以通过最后的处理总能得到题设形式）。
5. (*X-Y decomposition for a single qubit*) 证明任意单比特酉变换也可以写为 $U=exp(i al)R_X (beta)R_Y (gamma)R_X (delta)$ 的形式，证明：
  1. 已知 $H R_Z (tht)H=R_X (tht), H R_Y (tht)H=R_Y (-tht).$
  2. 对于任意单比特酉变换 $U$，显然 $U^*=H U H$ 也是酉的，可以写作 $U^*=exp(i al)R_Z (beta)R_Y (gamma)R_Z (delta)$ 的形式 
  3. 则有 $ H U^*H=U&=exp(i al) H R_Z (beta)R_Y (gamma)R_Z (delta)H \ &=exp(i al)H R_Z (beta)H H R_Y (gamma)H H R_Z (delta)H \ &=exp(i al) R_X (beta)R_Y (-gamma)R_X (beta) $
6. 定轴 $hat(n), hat(m)$（二者不平行），对于任意的酉变换 $U$，存在 $al, beta, gamma, delta$，使得 $U=exp(i al)R_hat(n) (beta) R_hat(m) (gamma) R_hat(n) (delta).$ 证明：
  1. 通过变基或者说旋转坐标系，可以使得 $hat(n)=hat(z), hat(m)'=(sin(tht),0,cos(tht)).$ 即 $U=exp(i al)R_hat(z) (beta) R_hat(m)' (gamma) R_hat(z) (delta)$
  2. 取 $U=mat(a, b; -b^*, a^*)$，只需证明等式右边也能写为此形式，并且 $al, beta, gamma, delta$ 有解即可。
7. Suppose $U$ is a unitary gate on a single qubit. Then there exist unitary operators $A, B, C$ on a single qubit such that* $A B C = I$ and $U = e^(i al) A X B X C$*, where $al$ is some overall phase factor. 这个重要引理会在后面构造任意受控门时用到。


== QFT and applications

1. *Fourier transform*
  1. (_discrete Fourier transform_)对于一组复数基向量 $x_0,...,x_N$，变换后：$ y_k equiv 1/sqrt(N)sum_(j=0)^(N-1)x_j e^(2 pi i j k\/N) $
  2. (_quantum Fourier transform_)类似地施加变换（这是一个酉变换），有：$ ket(j) arrow 1/sqrt(N)sum_(k=0)^(N-1)e^(2 pi i j k \/N)ket(k) $
  3. 任意量子态的变换：$ sum_(j=0)^(N-1)x_j ket(j) arrow sum_(k=0)^(N-1) y_k ket(k) $
2. (_product representation_)定义 $j=j_1 j_2 ... j_n = j_1*2^(n-1)+...+j_n*2^0$ 并且 $0.j_l j_(l+1)...j_m=j_l\/2+...+j_m\/2^(m-l+1) $，则 QFT 也可以表示为：$ ket(j_1...j_n)arrow ((ket(0)+e^(2pi i 0.j_n)ket(1))(ket(0)+e^(2pi i 0.j_(n-1) j_n)ket(1))...(ket(0)+e^(2pi i 0.j_1...j_n)ket(1)))/2^(n\/2) $ 证明逻辑是将 $ket(k)$ 拆分为张量积形式 $sum_(k_1=0)^1...sum_(k_n=0)^1 limits(times.circle)_(l=1)^n ket(k_l)$。
3. 制造一个量子门 $R_k=mat(1,0;0,exp(2pi i\/2^k))$，通过以下电路，就能实现 QFT(_product representation_)。#image("../images/qft_circuit.png")
4. 还需要 $n/2$ 次交换来达到 reverse 的效果，因此该电路使用 $Theta(n^2)$ 量级的门操作，这也就是该量子算法的复杂度。
5. (_fast Fourier transform_)首先有 $X_k=sum_(n=0)^(N-1)x_n e^(-i (2pi)/N k n)$，取 $omega_N=e^(-i (2pi)/N)$（称为旋转因子），则 $X_k=sum_(n=0)^(N-1)x_n omega_N^(k n)$。拆分为奇偶部分：$ X_k&=sum_(m=0)^(N\/2-1)x_(2m)omega_N^(2k m)+sum_(m=0)^(N\/2-1)x_(2m+1)omega_N^(k (2m+1))\ &=sum_(m=0)^(N\/2-1)x_(2m)omega_(N\/2)^(k m)+omega_N^k sum_(m=0)^(N\/2-1)x_(2m+1)omega_(N\/2)^(k m) \ &equiv E_k + omega_N^k O_k. $ 并且还有关系 $X_(k+N\/2)=E_k-omega_N^k O_k$，则对 $E_k$ 和 $O_k$ 继续分治即可（蝴蝶操作）。








= Quantum Information