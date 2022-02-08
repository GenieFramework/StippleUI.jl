module Badges

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export badge, Badge

register_normal_element("q__badge", context = @__MODULE__)

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
function badge( fieldname::Union{Symbol,String,Nothing} = nothing,
                args...; kwargs...) where {T<:Stipple.ReactiveModel}
  q__badge(args...;
          kw( [(isa(fieldname, String) ? :label : :fieldname) => fieldname, kwargs...] )...
  )
end

mutable struct Badge
  fieldname
  args
  kwargs

  Badge(fieldname::Union{Symbol,Nothing} = nothing,
        args...; kwargs...) = new(fieldname, args, kwargs)
end

Base.string(b::Badge) = badge(b.fieldname, b.args...; b.kwargs...)

end