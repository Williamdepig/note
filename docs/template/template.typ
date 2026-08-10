#import "@preview/ctheorems:1.1.3": *

#let serif-fonts = ("Times New Roman", "Noto Serif CJK SC")
#let sans-fonts = ("Times New Roman", "Noto Sans CJK SC")
#let kai-fonts = ("Times New Roman", "LXGW WenKai")
#let mono-font = "DejaVu Sans Mono"

// Merge 运算符：圆圈中的粗体直立 M。
#let mergeop = math.op(
    box(
        width: 1.1em,
        height: 1.1em,
        baseline: 15%,
        stroke: 0.06em,
        radius: 50%,
        inset: 0pt,
    )[
        #align(center + horizon)[
            #move(dy: -0.06em)[
                #text(size: 0.72em, weight: "bold")[M]
            ]
        ]
    ]
)

#let chinese_number(num, standalone: false) = if num < 11 {
    ("零", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十").at(num)
} else if num < 100 {
    if calc.rem(num, 10) == 0 {
        chinese_number(calc.floor(num / 10)) + "十"
    } else if num < 20 and standalone {
        "十" + chinese_number(calc.rem(num, 10))
    } else {
        chinese_number(calc.floor(num / 10)) + "十" + chinese_number(calc.rem(num, 10))
    }
} else if num < 1000 {
    let left = chinese_number(calc.floor(num / 100)) + "百"
    if calc.rem(num, 100) == 0 {
        left
    } else if calc.rem(num, 100) < 10 {
        left + "零" + chinese_number(calc.rem(num, 100))
    } else {
        left + chinese_number(calc.rem(num, 100))
    }
} else {
    let left = chinese_number(calc.floor(num / 1000)) + "千"
    if calc.rem(num, 1000) == 0 {
        left
    } else if calc.rem(num, 1000) < 10 {
        left + "零" + chinese_number(calc.rem(num, 1000))
    } else if calc.rem(num, 1000) < 100 {
        left + "零" + chinese_number(calc.rem(num, 1000))
    } else {
        left + chinese_number(calc.rem(num, 1000))
    }
}

// 在这里改变章节标题
#let chapter_numbering(nums) = {
    "第" + chinese_number(nums, standalone: true) + "章"
    // "Lecture " + str(nums)
}

// 编号方式
#let chinese_numbering(..nums, location: none) = context {
    let actual_loc = if location == none { counter(heading).get().first() } else { location }
    if nums.pos().len() == 1 {
        chapter_numbering(nums.pos().first())
    } else {
        numbering("1.1", ..nums)
    }
}



#let appendix_numbering(..nums, location: none) = context ( {
    let actual_loc = if location == none { counter(heading).get().first() } else { location }
    if nums.pos().len() == 1 {
        "附录 " + numbering("A.1", ..nums)
    } else {
        numbering("A.1", ..nums)
    }
})

#let set-appendix(doc) = {
    counter(heading).update(0)

    set heading(
        numbering: appendix_numbering
    )

    doc
}


#let theorem-title-font = sans-fonts
#let theorem-companion-font = kai-fonts

#let make-boxed-theorem(
    identifier,
    heading,
    blockcolor,
    emphcolor,
    stroke: none,
    inset: (x: 1.2em, y: 0.8em),
    body-font: none,
    base: "heading",
    base_level: 1,
) = thmbox(
    identifier,
    heading,
    fill: blockcolor,
    stroke: if stroke == none { blockcolor } else { stroke },
    radius: 0pt,
    inset: inset,
    breakable: true,
    base: base,
    base_level: base_level,
    supplement: heading,
    padding: (top: 0.45em, bottom: 0.45em),
    separator: [#h(0.5em)],
    titlefmt: title => text(font: theorem-title-font, emphcolor)[#title],
    namefmt: name => text(font: theorem-title-font, emphcolor)[（#name）],
    bodyfmt: body => [
        #if body-font != none {
            set text(font: body-font, style: "normal")
        }
        #set list(marker: (text(emphcolor)[•]))
        #set enum(numbering: n => text(emphcolor)[#n])
        #body
    ],
)

#let make-companion-theorem(
    identifier,
    heading,
    blockcolor,
    emphcolor,
    base: "heading",
    base_level: 1,
) = thmenv(
    identifier,
    base,
    base_level,
    (name, number, body, companion: none, companion-label: "证明", qed: false) => {
        let title = heading
        if number != none {
            title += number
        }

        pad(top: 0.45em, bottom: 0.45em)[
            #block(
                width: 100%,
                stroke: blockcolor + 2pt,
                radius: 0pt,
                inset: 0pt,
                breakable: true,
            )[
                #stack(
                    dir: ttb,
                    spacing: 0pt,
                    block(
                        width: 100%,
                        fill: blockcolor,
                        inset: (x: 1.2em, y: 0.8em),
                        breakable: true,
                    )[
                        #set list(marker: (text(emphcolor)[•]))
                        #set enum(numbering: n => text(emphcolor)[#n])
                        #text(font: theorem-title-font, emphcolor)[#title]
                        #if name != none [
                            #text(font: theorem-title-font, emphcolor)[（#name）]
                        ]
                        #h(0.5em)
                        #body
                        #parbreak()
                    ],
                    if companion != none {
                        block(
                            width: 100%,
                            fill: white,
                            inset: (x: 1.2em, y: 0.8em),
                            breakable: true,
                        )[
                            #set text(font: theorem-companion-font, style: "normal")
                            #set list(marker: (strong[•]))
                            #text(emphcolor)[#companion-label]
                            #h(0.5em)
                            #companion
                            #if qed [
                                #h(1fr)#sym.qed
                            ]
                        ]
                    } else { none },
                )
            ]
        ]
    },
).with(supplement: heading)

// 引文块的颜色
#let quoteblockcolor = rgb(239, 240, 243)
#let quotebordercolor = rgb("#2d3137")

// 类似 Markdown `>` 的引用块，可选作者署名。
#let quote(term, author: none) = block(
    width: 100%,
    breakable: true,
    fill: quoteblockcolor,
    stroke: (left: 0.25em + quotebordercolor),
    inset: (x: 1em, y: 0.75em),
    above: 0.75em,
    below: 0.75em,
)[
    #set align(left)
    #set text(font: serif-fonts)
    #set par(
        first-line-indent: 0pt,
        spacing: 0.5em,
    )
    #term
    #if author != none [
        #block(above: 0.5em)[
            #align(right)[—— #author]
        ]
    ]
]

// 以下是一些预定义的环境块
#let defblockcolor = rgb(220, 227, 248)
#let defemphcolor = rgb(31, 119, 184)

#let definition-env = make-boxed-theorem("definition", "定义", defblockcolor, defemphcolor)
#let def(term, supplement: none) = definition-env(supplement)[#term]

#let rmblockcolor = rgb(255, 237, 193)
#let rmemphcolor = rgb(215, 94, 106)

#let remark-env = make-boxed-theorem("remark", "注记", rmblockcolor, rmemphcolor)
#let rm(term, supplement: none) = remark-env(supplement)[#term]

#let conjblockcolor = rgb(255, 213, 206)
#let conjemphcolor = rgb(233, 66, 66)

#let conjecture-env = make-boxed-theorem("conjecture", "猜想", conjblockcolor, conjemphcolor)
#let conj(term, supplement: none) = conjecture-env(supplement)[#term]

#let egemphcolor = rgb(130, 110, 217)

#let example-env = make-boxed-theorem(
    "example",
    "例",
    white,
    egemphcolor,
    stroke: (y: (paint: egemphcolor, thickness: 1pt, dash: "dashed")),
    inset: (x: 1.2em, y: 1em),
    body-font: theorem-companion-font,
)
#let eg(term, supplement: none) = example-env(supplement)[#term]

#let thmblockcolor = rgb(209, 255, 226)
#let thmemphcolor = rgb(0, 134, 24)

#let theorem-env = make-companion-theorem("theorem", "定理", thmblockcolor, thmemphcolor)
#let corollary-env = make-companion-theorem("theorem", "推论", thmblockcolor, thmemphcolor)
#let lemma-env = make-companion-theorem("theorem", "引理", thmblockcolor, thmemphcolor)
#let proposition-env = make-companion-theorem("theorem", "命题", thmblockcolor, thmemphcolor)

#let thm(heading, proof: none, supplement: none) = theorem-env(
    supplement,
    companion: proof,
    companion-label: "证明",
    qed: true,
)[#heading]

#let coro(heading, proof: none, supplement: none) = corollary-env(
    supplement,
    companion: proof,
    companion-label: "证明",
    qed: true,
)[#heading]

#let lemma(heading, proof: none, supplement: none) = lemma-env(
    supplement,
    companion: proof,
    companion-label: "证明",
    qed: true,
)[#heading]

#let prop(heading, proof: none, supplement: none) = proposition-env(
    supplement,
    companion: proof,
    companion-label: "证明",
    qed: true,
)[#heading]

#let exemphcolor = rgb(35, 155, 171)
#let exblockcolor = rgb(161, 255, 238)

#let exercise-env = make-companion-theorem("exercise", "习题", exblockcolor, exemphcolor)
#let ex(heading, solution: none, supplement: none) = exercise-env(
    supplement,
    companion: solution,
    companion-label: "解答",
)[#heading]

#let theorem-ref-color(identifier) = if identifier == "definition" {
    defemphcolor
} else if identifier == "remark" {
    rmemphcolor
} else if identifier == "conjecture" {
    conjemphcolor
} else if identifier == "example" {
    egemphcolor
} else if identifier == "exercise" {
    exemphcolor
} else {
    thmemphcolor
}

#let endofchapter() = {
    [#pagebreak()]
}

#let makecontent() = [
    #show outline: set heading(
        numbering: (..nums) => "",
    )
    #outline(title: align(center)[目录])

    #pagebreak()
    #counter(heading).update(0)
]

#let conf(doc, chapter_numbering: chapter_numbering) = {
    show: thmrules.with(qed-symbol: $qed$)

    set heading(
        numbering: chinese_numbering
    )

    show heading: it => block(
        below: {
            if it.level == 1 {
                25pt // 大层级与正文的距离
            } else {
                15pt // 小层级与正文的距离
            }
        },
    )[
        #set text(
            font: sans-fonts, // 标题字体
            weight: "regular"
        )
        #counter(heading).display()
        #it.body
    ]

    set text(
        font: serif-fonts
    )

    show emph: set text(
        font: kai-fonts,
    )

    show strong: set text(
        font: sans-fonts
    )

    show raw: set text(
        font: mono-font
    )

    set enum(
        indent: 2em,
    )

    set list(
        indent: 2em,
    )

    show figure: set block(breakable: true)

    show ref: it => {
        let eq = math.equation
        let el = it.element
        if el != none {
            if el.func() == heading {
                // for heading
                link(el.location(), [#numbering(
                        el.numbering, ..counter(heading).at(el.location())
                    )])
            // } else if el.func() == eq {
            //     link(el.location(), [公式 #numbering(
            //             el.numbering, ..counter(eq).at(el.location())
            //         )])
            } else if el.func() == figure and el.kind == "thmenv" {
                let supplement = el.supplement
                if it.citation.supplement != none {
                    supplement = it.citation.supplement
                }

                let loc = el.location()
                let thms = query(selector(<meta:thmenvcounter>).after(loc))
                let identifier = thms.first().value
                let number = thmcounters.at(thms.first().location()).at("latest")
                let refbody = [#supplement~#numbering(el.numbering, ..number)]
                link(
                    it.target,
                    text(
                        font: theorem-title-font,
                        weight: "bold",
                        theorem-ref-color(identifier),
                        refbody,
                    ),
                )
            } else if el.func() == figure {
                link(el.location(), [#el.supplement #numbering(el.numbering, ..el.counter.at(el.location()))])
            } else {
                it
            }
        } else {
            it
        }
    }

    doc
}
