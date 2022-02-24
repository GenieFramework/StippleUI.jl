using Stipple
using StippleUI

@reactive mutable struct CheckboxModel <: ReactiveModel
  valone::R{Bool} = true
  right2::R{Bool} = true
end

function handlers(checkbox_model)
  on(checkbox_model.valone) do valone
    if valone == true
      @info "value is true"
    else
      @info "value is false"
    end
  end
  checkbox_model
end

function ui(checkbox_model)
  page(
    checkbox_model,
    title = "Checkbox Components",
    class = "container",
    [
      checkbox(label = "Apples", fieldname = :valone, dense = true, size = "xl")
    ],
  )
end

route("/") do
  init(CheckboxModel) |> handlers |> ui |> html
end

up()