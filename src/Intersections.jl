module Intersections

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export intersection

function __init__()
  Genie.Renderer.Html.register_normal_element("q__intersection", context = Genie.Renderer.Html)
end

function intersection(args...;
                      wrap::Function = StippleUI.DEFAULT_WRAPPER,
                      kwargs...)

  wrap() do
    Genie.Renderer.Html.q__intersection(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

end
