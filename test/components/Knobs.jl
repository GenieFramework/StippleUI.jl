module Knobs

using Stipple
using StippleUI

@reactive mutable struct KnobModel <: ReactiveModel
  value::R{Int} = 81
  name::R{String} = "volume_up"
  range_data::R{StepRange{Int64, Int64}} = (1:3:100)
  thick::R{Float64} = 0.34
end

function ui(knob_model)
  page(
    knob_model,
    title = "Rating Components",
    class = "container", [
    myknob(min=:range_data, max=:range_data, step=:range_data, thickness=:thick, :value, showvalue=true, class="text-light-blue q-ma-md", size="50px", color="light-blue"),
    # knob(:value, :range_data)
    # knob(min=:range_data, max=:range_data, step=:range_data, fontsize="12px", showvalue=true, size="50px", 
    # thickness=:thick, color="teal", trackcolor="grey-3", class="q-ma-md")
    ]
  )
end

function factory()
  knob_model = KnobModel |> init
  knob_model
end

end