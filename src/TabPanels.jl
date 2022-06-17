module TabPanels

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export tabpanels

register_normal_element("q__tab__panels", context = @__MODULE__)

function tabpanels(args...; kwargs...)
  q__tab__panels(args...; kw(kwargs)...)
end

end