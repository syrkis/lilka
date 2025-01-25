#import "utils.typ": *


// src/templates/lib.typ
#let paper(
  title: none,
  author: none,
  date: none,
  abstract: none,
  doc,
) = {
  // Base styling
  show figure: it => {
    it.body
    pad(text(size: 0.9em, it.caption))
  }

  // Your blog post content goes here
  align(center)[
    #block(spacing: 2em)[
      #format-title(title)
      // #title

      #if author != none [#text(size: 1.2em)[#author]]

      #if date != none [
        #text(
          size: 1em,
          style: "italic",
        )
        format-date(date)
      ]
    ]
  ]

  // add abstract
  if abstract != none {
    v(20pt, weak: true)
    set text(12pt)
    show: pad.with(x: 35pt)
    smallcaps[Abstract. ]
    abstract
  }

  doc
}
