#import "style.typ": style

#let vitae(
  title: none,
  name: none,
  subtitle: none,
  contact: (),
  languages: (),
  skills: (),
  summary: none,
  body,
) = {
  set page(paper: "us-letter")
  set text(font: style.font)
  show heading: it => [
    #block()[
      #v(-0.5em)
      #set text(weight: "regular", tracking: 0.2em, size: 12pt)
      #line(length: 100%, stroke: 2pt)
      #v(0.5em)
      #upper(align(text(it.body), center))
      #v(-0.3em)
      #line(length: 100%)
    ]
  ]
  //
  if name != none {
    align(upper(text(17pt, name, tracking: 0.2em)), center)
  }
  if contact != none {
    align(
      par(grid(columns: (1fr,) * 3, ..contact.map(c => [#c]), row-gutter: 0em)),
      center,
    )
  }
  line(length: 100%, stroke: 2pt)
  // if subtitle != none {
  align(text(upper(subtitle), tracking: 0.2em), center)
  line(length: 100%, stroke: 1pt)
  // }
  if summary != none {
    align(par(text(summary)), center)
  }
  if skills != () {
    v(0.5em)
    align(
      grid(columns: (1fr,) * 3, ..skills.map(s => [#s]), row-gutter: 1em),
      center,
    )
  }
  // justify text
  set par(justify: true)
  body
}
#let entry(
  title: none,
  subtitle: none,
  date: none,
  url: none,
  body,
) = {
  grid(
    row-gutter: 0em,
    columns: (1fr, auto),
    [#strong(title), #subtitle, #date], url,
  )
  v(-0.5em) // Add negative vertical space
  body
}
