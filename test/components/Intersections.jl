module Intersections

using Stipple, StippleUI

export IntersectionModel

@reactive! mutable struct IntersectionModel <: ReactiveModel
end

function ui(intersection_model)
  page(
    intersection_model,
    title = "Icon Components",
    class = "q-pa-md q-gutter-sm",
    [
      icon("font_download", class="text-primary", style="font-size: 32px;"),
      icon("warning", class="text-red", style="font-size:4rem;"),
      icon("format_size", style="color: #ccc; font-size: 1.4em;"),
      icon("print", class="text-teal", style="font-size: 4.4em;"),
      icon("today", class="text-orange", style="font-size: 2em;"),
      icon("style", style="font-size: 3em;"),
    ]
  )
end

function factory()
  intersection_model = IntersectionModel |> init
  intersection_model
end

end