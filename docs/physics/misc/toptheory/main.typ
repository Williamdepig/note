#import "@local/mathnote:0.1.0": *
#import "@preview/ilm:1.4.1": *

#show: ilm.with(
  title: [模板使用说明],
  author: "Anyone",
  // date: datetime(year: 2025, month: 08, day: 08),
  date: datetime.today(),
  abstract: [
    Abstract
  ],
  // preface: [
  //   #align(center + horizon)[
  //     Thank you for using this template #emoji.heart,\ I hope you like it #emoji.face.smile
  //   ]
  // ],
  bibliography: bibliography("refs.bib", style: "ieee"),
  // figure-index: (enabled: true),
  // table-index: (enabled: true),
  // listing-index: (enabled: true),
  paper-size: "a4",
  table-of-contents: none
)
= 使用说明
== 数学环境块
1. 定义: `#def[]`
2. 定理: `#thm([], proof: [])`
3. 引理: `#lemma([], proof: [])`
4. 命题: `#prop([], proof: [])`
5. 例: `#eg[]`
6. 注记: `#rm[]`
7. 猜想: `#conj[]`
8. 推论: `#coro[]`
9. 习题: `#ex([], solution: [])`

== 额外环境块
1. 强调: `#emph-box[]` 
2. 引用: `#quote-box[]`
3. 注意: `#note-box[]`
4. 建议: `#tip-box[]`
5. 关键: `#important-box[]`
6. 警告: `#warning-box[]`
7. 负面: `#caution-box[]`