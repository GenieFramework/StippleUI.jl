module Spaces

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template

export space

function __init__()
  Genie.Renderer.Html.register_normal_element("q__space", context = Genie.Renderer.Html)
end

function space(args...; wrap::Function = StippleUI.DEFAULT_WRAPPER, kwargs...)
  wrap() do
    Genie.Renderer.Html.q__space(args...; kwargs...)
  end
end

end
