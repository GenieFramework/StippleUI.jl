module Drawers

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export drawer

register_normal_element("q__drawer", context = @__MODULE__)

function drawer(args...; kwargs...)
  q__drawer(args...; kw(kwargs)...)
end

end
