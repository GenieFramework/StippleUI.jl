using Stipple
using StippleUI

@reactive mutable struct CheckboxModel <: ReactiveModel
  valone::R{Bool} = true
  valtwo::R{Bool} = true
  valthree::R{Bool} = true
end

function ui(checkbox_model)
  page(
    checkbox_model,
    class = "container",
    [
      checkbox(label = "Apples", fieldname = :valone, dense = true, color="teal")
    ],
  )
end

route("/") do
  init(CheckboxModel) |> ui |> html
end

up()