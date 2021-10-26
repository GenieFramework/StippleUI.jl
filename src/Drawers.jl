module Drawers

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export drawer

function __init__()
  Genie.Renderer.Html.register_normal_element("q__drawer", context = Genie.Renderer.Html)
end

function drawer(args...;
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                kwargs...)

  wrap() do
    Genie.Renderer.Html.q__drawer(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

end
