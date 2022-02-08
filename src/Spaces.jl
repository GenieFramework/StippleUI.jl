module Spaces

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template, register_normal_element

export space

register_normal_element("q__space", context = @__MODULE__)

function space(args...; kwargs...)
  q__space(args...; kw(kwargs)...)
end

end
