module Checkbox

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export checkbox

Genie.Renderer.Html.register_normal_element("q__checkbox", context = @__MODULE__)

function checkbox(label::String = "",
                  fieldname::Union{Symbol,Nothing} = nothing,
                  args...;
                  wrap::Function = StippleUI.DEFAULT_WRAPPER,
                  kwargs...)

  wrap() do
    q__checkbox(args...; attributes([:label => label, :fieldname => fieldname, kwargs...],
                                    Dict("fieldname" => "v-model", "indeterminatevalue" => "indeterminate-value", "toggleorder" => "toggle-order",
                                          "truevalue" => "true-value", "falsevalue" => "false-value", "toggleindeterminate" => "toggle-indeterminate",
                                          "keepcolor" => "keep-color", "leftlabel" => "left-label"))...)
  end
end

end
