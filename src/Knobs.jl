module Knobs

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, void_element, template, register_void_element

using Stipple

export knob

register_void_element("q__knob", context = @__MODULE__)

"""
    knob()

Renders a knob input element.
"""
function knob(  val::Int,
                range::AbstractRange{T} where T <: Real,
                fieldname::Union{Symbol,Nothing} = nothing,
                args...;
                kwargs...)

  q__knob(  args...; kw([ 
            Symbol(":min") => first(range),
            Symbol(":max") => last(range),
            Symbol(":step") => step(range),
            Symbol(":thickness") => step(val),
            :fieldname => fieldname,
            kwargs...
  ])...)
end

end
