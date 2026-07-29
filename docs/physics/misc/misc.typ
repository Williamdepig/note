#import "@preview/physica:0.9.8": *
#set text(
    font: ("Times New Roman", "Noto Serif CJK SC")
)

= MISC
== 解决由于进程调度导致程序计时不准问题
1. 考虑 perf 
2. 进程亲和

== 纠错问题
1. 逻辑比特的表示：$ ket(phi)_L = a ket(0)_L + b ket(1)_L $ 我们知道逻辑比特可以分解为逻辑 0 和逻辑 1，接下来的复杂步骤就是如何实现逻辑操作。