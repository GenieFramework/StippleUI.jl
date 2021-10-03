module Spaces

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template

export space

Genie.Renderer.Html.register_normal_element("q__space", context = @__MODULE__)

function space(args...; wrap::Function = StippleUI.DEFAULT_WRAPPER, kwargs...)
  wrap() do
    q__space(args...; kwargs...)
  end
end

end
