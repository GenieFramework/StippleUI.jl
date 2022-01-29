module MTabs

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export mtab

register_normal_element("q__tabs", context = @__MODULE__)

"""
    mtab()
Renders a Qtabs layout element.
"""
function mtab(args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              kwargs...)
  wrap() do
    q__tabs(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

end
