module Separator

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template

export separator

Genie.Renderer.Html.register_normal_element("q__separator", context = @__MODULE__)

function separator(args...; wrap::Function = StippleUI.DEFAULT_WRAPPER, kwargs...)
  wrap() do
    q__separator(args...; kwargs...)
  end
end

end
