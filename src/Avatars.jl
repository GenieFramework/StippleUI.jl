module Avatars

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export avatar

register_normal_element("q__avatar", context = @__MODULE__)


function avatar(args...; kwargs...)
  q__avatar(args...; kw(kwargs)...)
end


end