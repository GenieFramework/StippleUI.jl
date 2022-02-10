module Intersections

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export intersection

register_normal_element("q__intersection", context = @__MODULE__)

function intersection(args...; kwargs...)
  q__intersection(args...; kw(kwargs)...)
end

end
