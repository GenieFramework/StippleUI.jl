module Forms

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export form

function __init__()
  Genie.Renderer.Html.register_normal_element("q__form", context = Genie.Renderer.Html)
end

function form(args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              noresetfocus::Bool = false,
              kwargs...)
  wrap() do
    Genie.Renderer.Html.q__form(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

end
