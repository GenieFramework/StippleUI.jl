module Separators

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template, register_normal_element

export separator

register_normal_element("q__separator", context = @__MODULE__)

"""
      separator(args...; kwargs...)

The `separator` component is used to separate sections of text, other components, etc… It creates a colored line across the width of the parent. It can be horizontal or vertical.
"""
function separator(args...; kwargs...)
  q__separator(args...; kw(kwargs)...)
end

end
