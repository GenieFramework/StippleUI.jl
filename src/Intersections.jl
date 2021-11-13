module Intersections

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export intersection

register_normal_element("q__intersection", context = @__MODULE__)

function intersection(args...;
                      wrap::Function = StippleUI.DEFAULT_WRAPPER,
                      kwargs...)

  wrap() do
    q__intersection(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

end
