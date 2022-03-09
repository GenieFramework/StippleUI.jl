module Toggles

using Stipple
using StippleUI

@reactive mutable struct ToggleModel <: ReactiveModel
  value::R{Bool} = false
  selection::R{Vector{String}} = ["yellow", "red"]
end

function ui(toggle_model)
  page(
    toggle_model,
    title = "Toggle Components",
    class = "container",
    [
      Html.div([
        toggle("Play on off", :value)
      ]),

      p("Value of toggle: {{value}}"),

      Html.div(class="q-pa-md q-gutter-sm", [
        toggle("Blue", color="blue", :selection, val="blue"),
        toggle("Yellow", color="yellow", :selection, val="yellow"),
        toggle("Green", color="green", :selection, val="green"),
        toggle("Red", color="red", :selection, val="red"),
      ]), 

      p("Array of selected values: {{selection}}")
    ],
  )
end

function factory()
  toggle_model = ToggleModel |> init
  toggle_model
end

end