module Badge

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export badge

Genie.Renderer.Html.register_normal_element("q__badge", context = @__MODULE__)

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
function badge( fieldname::Union{Symbol,Nothing} = nothing,
                args...;
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                kwargs...) where {T<:Stipple.ReactiveModel}
  wrap() do
    q__badge(args...;
            attributes(
              [:fieldname => fieldname, kwargs...],
              StippleUI.API.ATTRIBUTES_MAPPINGS
            )...)
  end
end

end