module Form

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export form

Genie.Renderer.Html.register_normal_element("q__form", context = @__MODULE__)

function form(args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              noresetfocus::Bool = false,
              kwargs...)
  wrap() do
    q__form(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

end
