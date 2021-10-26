module Layouts

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export layout, pageContainer, page

function __init__()
  Genie.Renderer.Html.register_normal_element("q__layout", context = Genie.Renderer.Html)
  Genie.Renderer.Html.register_normal_element("q__page__container", context = Genie.Renderer.Html)
  Genie.Renderer.Html.register_normal_element("q__page", context = Genie.Renderer.Html)
end


function layout(args...;
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                kwargs...)
     wrap() do
      Genie.Renderer.Html.q__layout(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
     end
end

function page_container(args...;
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                kwargs...)
      wrap() do
        Genie.Renderer.Html.q__page__container(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
      end
end

function page(args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              kwargs...)
      wrap() do
        Genie.Renderer.Html.q__page(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
      end
end


end
