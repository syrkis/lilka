#import "src/slide.typ": *
#import "src/codex.typ": *
#import "src/paper.typ": *
#import "src/vitae.typ": *
#import "src/wwweb.typ": *
#import "@preview/equate:0.2.1": equate

#let style = (
  numbering: "1.1 |",
  leading: 1.3em,
  list-marker: "▶",
)

#let lilka(doc) = {
  // base styling
  set par(justify: true)
  set list(marker: style.list-marker)

  // equation numbering
  show: equate.with(breakable: true, sub-numbering: true)
  set math.equation(numbering: "(1.1)", supplement: "Eq.")
  set heading(numbering: "1.1 |")
  show heading: it => {
    set text(weight: "regular") // only for paper
    pad(top: 1.5em, bottom: 1em, it) // only for paper
  }
  doc
}
