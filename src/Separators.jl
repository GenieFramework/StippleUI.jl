module Separators

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template

export separator

function __init__()
  Genie.Renderer.Html.register_normal_element("q__separator", context = Genie.Renderer.Html)
end

function separator(args...; wrap::Function = StippleUI.DEFAULT_WRAPPER, kwargs...)
  wrap() do
    Genie.Renderer.Html.q__separator(args...; kwargs...)
  end
end

end
