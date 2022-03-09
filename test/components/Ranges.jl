module Ranges

using Stipple
using StippleUI

@reactive mutable struct RangeModel <: ReactiveModel
  range_data::R{RangeData{Int}} = RangeData(18:80)
end

function ui(range_model)
  page(
    range_model,
    title = "Range Components",
    class = "container",
    [
      Html.div(class="row justify-around", [
        range(18:1:90,
              :range_data;
              label=true,
              color="purple",
              labelalways=true,
              labelvalueleft=Symbol("'Min age: ' + range_data.min"),
              labelvalueright=Symbol("'Max age: ' + range_data.max"))
      ])
    ],
  )
end

function factory()
  range_model = RangeModel |> init
  range_model
end

end