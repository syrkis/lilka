#let format-date(date) = {
  date.display("[month repr:long] [day padding:none], [year]")
}

#let format-title(title) = {
  set par(leading: 1.5em)
  set align(center)
  text(size: 21pt, weight: "regular", stretch: 100%)[#smallcaps(title)]
}
