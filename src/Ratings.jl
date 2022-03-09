module Ratings

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export rating

register_normal_element("q__rating", context = @__MODULE__)

function rating(fieldname::Union{Symbol,Nothing} = nothing,args...; kwargs...)
  q__rating(args...; kw([:fieldname => fieldname, kwargs...])...)
end

end
