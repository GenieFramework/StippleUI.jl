module Lists

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export list, item, item_section, itemsection, item_label, itemlabel

function __init__()
  Genie.Renderer.Html.register_normal_element("q__list", context = Genie.Renderer.Html)
  Genie.Renderer.Html.register_normal_element("q__item", context = Genie.Renderer.Html)
  Genie.Renderer.Html.register_normal_element("q__item__section", context = Genie.Renderer.Html)
  Genie.Renderer.Html.register_normal_element("q__item__label", context = Genie.Renderer.Html)
end

function list(args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              kwargs...)
  wrap() do
    Genie.Renderer.Html.q__list(args...; kwargs...)
  end
end


function item(args...; kwargs...)
  Genie.Renderer.Html.q__item(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
end


function item_section(args...; kwargs...)
  Genie.Renderer.Html.q__item__section(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
end
const itemsection = item_section


function item_label(args...; kwargs...)
  Genie.Renderer.Html.q__item__label(args...; kwargs...)
end
const itemlabel = item_label

end
