module Knobs

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template, register_normal_element

using Stipple

export knob

register_normal_element("q__knob", context = @__MODULE__)

"""
      knob(range::AbstractRange{T} where T <: Real, fieldname::Union{Symbol,Nothing} = nothing, args...; kwargs...)

Renders a knob input element.
"""
function knob(
                range::AbstractRange{T} where T <: Real,
                fieldname::Union{Symbol,Nothing} = nothing,
                args...;
                kwargs...)

  q__knob(  args...; kw([ 
            Symbol(":min") => first(range),
            Symbol(":max") => last(range),
            Symbol(":step") => step(range),
            :fieldname => fieldname,
            kwargs...
  ])...)
end

end
