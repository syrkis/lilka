// #import "style.typ": *
#import "utils.typ": *
#import "@preview/equate:0.2.1": equate
#import "@preview/subpar:0.2.1"
#import "@preview/i-figured:0.2.4"


// src/templates/lib.typ
#let codex(
  title: none,
  cover: none,
  authors: none,
  // date: none,
  // abstract: none,
  doc,
) = {
  // base styling
  // set text(font: style.font, lang: "en", size: 13pt)
  // set page(height: auto, margin: (x: 0.1in, y: 0.1in))
  show: equate.with(breakable: true, sub-numbering: true)
  set math.equation(numbering: "(1.1)", supplement: "Eq.")

  show heading: it => [
    #set align(center)
    #set text(1em, weight: "regular")
    #v(2em)
    #block(smallcaps(it))
    #v(1em)
  ]

  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    it
  }
  set math.equation(
    numbering: (..num) => numbering(
      "(1.1)",
      counter(heading).get().first(),
      num.pos().first(),
    ),
  )
  set figure(
    numbering: (..num) => numbering(
      "1.1.a",
      counter(heading).get().first(),
      num.pos().first(),
    ),
  )

  // Your blog post content goes here
  set par(
    justify: true,
    leading: 0.65em,
  )


  set raw(align: left)

  align(center)[
    #block(spacing: 2em)[
      #format-title(title)
    ]
  ]

  if authors != none {
    align(center)[
      #block(spacing: 2em)[
        #text(size: 1.2em)[#authors]
      ]
    ]
  }

  if cover != none {
    cover
  }

  // add abstract
  // set heading(numbering: style.numbering)

  outline()
  // apply the show rules (these can be customized)
  show heading: i-figured.reset-counters
  show figure: i-figured.show-figure.with(level: 1)

  // show an outline
  i-figured.outline()

  pagebreak()

  doc
}
