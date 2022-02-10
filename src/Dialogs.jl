module Dialogs

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export dialog

register_normal_element("q__dialog", context = @__MODULE__)

function dialog(args...; kwargs...)
  q__dialog(args...; kw(kwargs)...)
end

end
