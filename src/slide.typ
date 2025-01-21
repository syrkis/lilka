#import "@preview/touying:0.5.5": *
#import "@preview/equate:0.2.1": equate
#import "style.typ": style
#import "utils.typ": format-date, format-title

// Base slide configuration
#let slide-defaults = (
  aspect-ratio: "16-9",
  margins: (x: 2.5em, top: 4.5em, bottom: 3em),
  header: self => utils.display-current-heading(depth: self.slide-level),
  footer: context utils.slide-counter.display(),
)

// Header and footer components
#let make-header(self) = {
  set text(size: 1.3em)
  place(
    left,
    dx: 1.5em,
    dy: 1.5em,
    utils.call-or-display(
      self,
      utils.call-or-display(self, self.store.header),
    ),
  )
}

#let make-footer(self) = {
  set text(size: 0.8em)
  place(
    right,
    dx: -2em,
    context {
      utils.slide-counter.display() + " of " + utils.last-slide-number
    },
  )
}

// Basic slide template
#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-page(
      header: make-header,
      footer: make-footer,
    ),
  )
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: setting,
    composer: composer,
    ..bodies,
  )
})

// Cover slide component
#let cover-slide(leading: 50pt) = touying-slide-wrapper(self => {
  let make-info-section = {
    set par(leading: 20pt)
    context {
      // text(self.info.title, size: 28pt)
      format-title(self.info.title)
      v(1em)
      text(size: 20pt, weight: "regular", self.info.author)
      if self.info.institution != none {
        v(0.1em)
        text(size: 20pt, weight: "regular", self.info.institution)
      }
      if self.info.date != none {
        v(0.1em)
        text(size: 14pt, format-date(self.info.date))
      }
    }
  }

  let make-outline = {
    set par(leading: leading)
    set text(size: 24pt)
    components.custom-progressive-outline(
      level: none,
      depth: 1,
      numbered: (true,),
    )
  }

  set text(size: 24pt)
  set par(leading: leading)

  let body = grid(
    columns: (1fr, 1fr),
    rows: 1fr,
    gutter: 3em,
    align(center + horizon, make-info-section),
    align(left + horizon, make-outline),
  )

  let self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 0em),
  )
  touying-slide(self: self, body)
})

// Focus slide
#let focus-slide(body) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
  )
  touying-slide(self: self, align(horizon + center, body))
})

// Appendix utilities
#let appendix-ref-format = (..nums) => "Appendix " + numbering("A", ..nums)

#let appendix(body) = {
  counter(heading).update(0)
  show heading.where(level: 1): set heading(
    numbering: "A |",
    outlined: false,
    supplement: [Appendix],
  )
  set align(horizon)
  body
}

// Main slides function
#let slides(
  aspect-ratio: slide-defaults.aspect-ratio,
  header: slide-defaults.header,
  footer: slide-defaults.footer,
  ..args,
  body,
) = {
  // Apply global styles
  set text(size: style.text-size, font: style.font)
  set par(leading: style.leading)
  set align(horizon)
  set list(marker: style.list-marker)

  // Configure headings
  show heading.where(level: 1): set heading(numbering: style.numbering)
  set heading(numbering: "1.1 |")
  // show heading.where(level: 2): set heading(numbering: (..nums) => "1 |")

  // Configure math and equations
  show: equate.with(breakable: true, sub-numbering: true)
  set math.equation(numbering: "(1.1)", supplement: "Eq.")

  // Configure slides
  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      margin: slide-defaults.margins,
    ),
    config-common(
      slide-fn: slide,
      datetime-format: "[month repr:long] [day padding:none], [year]",
    ),
    config-methods(
      init: (self: none, body) => {
        show strong: self.methods.alert.with(self: self)
        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-store(
      align: align,
      header: header,
      footer: footer,
    ),
    ..args,
  )

  body
}
