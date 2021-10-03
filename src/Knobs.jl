module Knobs

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, void_element, template

using Stipple

export knob

Genie.Renderer.Html.register_void_element("q__knob", context = @__MODULE__)

"""
    knob()

Renders a knob input element.
"""
function knob(
                range::AbstractRange{T} where T <: Real,
                fieldname::Union{Symbol,Nothing} = nothing,
                args...;
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                kwargs...)

  wrap() do
    q__knob(  args...;
              attributes(
                        [ Symbol(":min") => first(range),
                          Symbol(":max") => last(range),
                          Symbol(":step") => step(range),
                          :fieldname => fieldname,
                          kwargs...
                        ], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

end
