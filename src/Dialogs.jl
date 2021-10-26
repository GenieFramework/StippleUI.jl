module Dialogs

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export dialog

function __init__()
  Genie.Renderer.Html.register_normal_element("q__dialog", context = Genie.Renderer.Html)
end

function dialog(args...;
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                kwargs...)

  wrap() do
    Genie.Renderer.Html.q__dialog(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

end
