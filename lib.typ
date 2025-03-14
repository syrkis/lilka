#import "src/slide.typ": *
#import "src/codex.typ": *
#import "src/paper.typ": *

#import "@preview/equate:0.2.1": equate

#let style = (
  font: "New Computer Modern",
  numbering: "1.1 |",
  leading: 1.3em,
  list-marker: "▶",
)

#let lilka(doc) = {
  // base styling
  set text(font: style.font, lang: "en")
  set par(justify: true)
  set list(marker: style.list-marker)

  // heading style
  set heading(numbering: style.numbering)
  show heading: it => {
    set text(weight: "regular") // only for paper
    pad(top: 1.5em, bottom: 1em, it) // only for paper
  }

  // equation numbering
  show: equate.with(breakable: true, sub-numbering: true)
  set math.equation(numbering: "(1.1)", supplement: "Eq.")

  // content
  doc
}
