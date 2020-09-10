module Badge

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export badge

Genie.Renderer.Html.register_normal_element("q__badge", context = @__MODULE__)

const mappings = Dict("fieldname" => "v-model", "textcolor" => "text-color", "multiline" => "multi-line")

"""
floating::Bool = false
transparent::Bool = false
multiline::Bool = true
label::String = "Label"
align::String = "top" # middle, bottom
outline::Bool = true
color::String = "blue"
textcolor::String = "teal-10"
"""
function badge( model::T,
                fieldname::Union{Symbol,Nothing} = nothing,
                args...;
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                kwargs...) where {T<:Stipple.ReactiveModel}
  wrap() do
    q__badge(args...;
            attributes(
              model::T,
              [:fieldname => fieldname, kwargs...],
              mappings
            )...)
  end
end

function __init__() :: Nothing
  Stipple.rendering_mappings(mappings)

  nothing
end

end