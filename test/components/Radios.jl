module Radios

using Stipple
using StippleUI

@reactive mutable struct RadioModel <: ReactiveModel
  shape::R{String} = "line"
end

function ui(radio_model)
  page(
    radio_model,
    title = "Radio Components",
    class = "container",
    [
      Html.div(class="q-pa-md bg-grey-10 text-white", [
        Html.div(class="q-gutter-sm", [
          radio("Line", :shape, val="line"),
          radio("Rectangle", :shape, val="rectange"),
          radio("Ellipse", :shape, val="ellipse"),
          radio("Polygon", :shape, val="polygon")
        ])
      ]),
      Html.div(class="q-px-sm", [
        p("Your selection is: {{shape}}")
      ])
    ],
  )
end

function factory()
  radio_model = RadioModel |> init
  radio_model
end

end