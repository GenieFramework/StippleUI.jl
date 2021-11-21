module ScrollAreas

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template, register_normal_element

export scrollarea

register_normal_element("q__scroll__area", context = @__MODULE__)

function scrollarea(args...; wrap::Function = StippleUI.DEFAULT_WRAPPER, kwargs...)
  wrap() do
    q__scroll__area(args...; kwargs...)
  end
end

end
