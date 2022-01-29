module RTabs

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export rtab

register_normal_element("q__route__tab", context = @__MODULE__)

"""
    rtab()
Renders a QRouteTab layout element.
"""
function rtab(args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              kwargs...)
  wrap() do
    q__route__tab(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

end

