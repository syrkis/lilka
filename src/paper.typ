#import "style.typ": *
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
  set text(font: style.font, lang: "en", size: 13pt)
  // set page(height: auto, margin: (x: 0.1in, y: 0.1in))

  show figure: it => {
    set text(size: 0.9em)
    block(
      width: 100%,
      [
        #it.body
        #v(0.65em)
        #pad(
          x: 20pt, // Same padding as abstract
          text(
            size: 0.9em,
            weight: "regular",
            it.caption,
          ),
        )
      ],
    )
  }
  show heading: it => [
    #set align(center)
    #set text(1em, weight: "regular")
    #v(2em)
    #block(smallcaps(it))
    #v(1em)
  ]

  // Your blog post content goes here
  set par(
    justify: true,
    leading: 0.65em,
  )

  set raw(align: left)

  align(center)[
    #block(spacing: 2em)[
      #format-title(title)

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
  // Main content
  set heading(numbering: style.numbering)
  doc
}
