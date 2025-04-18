#import "@preview/touying:0.6.1": *
#import "@preview/equate:0.2.1": equate
#import "utils.typ": format-date, format-title

// Base slide configuration
#let slide-defaults = (
  aspect-ratio: "16-9",
  // margins: (x: 2.5em, top: 4.5em, bottom: 3em),
  header: self => utils.display-current-heading(depth: self.slide-level),
  footer: context utils.slide-counter.display(),
)

#let appendix(body) = {
  counter(heading).update(0)
  show heading.where(level: 1): set heading(
    numbering: "A |",
    outlined: false,
    supplement: [Appendix],
  )
  body
}

// Header and footer components
#let make-header(self) = {
  set text(size: 1.3em)
  place(
    left,
    dx: 1em,
    dy: 1em,
    utils.call-or-display(
      self,
      utils.call-or-display(self, self.store.header),
    ),
  )
}

#let make-footer(self) = {
  place(
    right,
    dx: -1.5em,
    dy: -0.5em,
    context {
      set text(size: 0.7em)
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
  set align(horizon)
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
#let title-slide() = touying-slide-wrapper(self => {
  set par(leading: 2em)
  let title-col = {
    context {
      set text(size: 0.9em)
      pad(x: 1em, y: 1em, format-title(self.info.title))
      pad(x: 1em, y: 1em, text(self.info.author))
      pad(text(size: 14pt, format-date(self.info.date)))
    }
  }

  let table-col = {
    set text(size: 1.3em)
    components.custom-progressive-outline(
      depth: 1,
      numbered: (true,),
      vspace: (0.5em,),
    )
  }

  let body = grid(
    columns: (1fr, 1fr),
    rows: 1fr,
    gutter: 2em,
    align(center + horizon, title-col), align(left + horizon, table-col),
  )

  let self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 1em),
  )
  touying-slide(self: self, body)
})

// Focus slide
#let focus-slide(body) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(self, config-common(freeze-slide-counter: true))
  touying-slide(self: self, align(horizon + center, body))
})

// Main slides function
#let slides(
  aspect-ratio: "16-9",
  header: slide-defaults.header,
  footer: slide-defaults.footer,
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      margin: (y: 2em, x: 2em),
    ),
    config-common(slide-fn: slide), // , margin: 2em),
    config-store(align: align, header: header, footer: footer),
    ..args,
  )


  set align(horizon)
  set text(size: 1.7em)
  set par(leading: 1.3em)
  title-slide()
  body
}
