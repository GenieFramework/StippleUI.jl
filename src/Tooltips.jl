module Tooltips

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export tooltip

register_normal_element("q__tooltip", context = @__MODULE__)

function tooltip(args...; kwargs...)
  q__tooltip(args...; kw(kwargs)...)
end

end