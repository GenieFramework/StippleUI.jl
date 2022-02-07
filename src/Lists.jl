module Lists

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export list, item, item_section, itemsection, item_label, itemlabel

register_normal_element("q__list", context = @__MODULE__)
register_normal_element("q__item", context = @__MODULE__)
register_normal_element("q__item__section", context = @__MODULE__)
register_normal_element("q__item__label", context = @__MODULE__)

function list(args...; kwargs...)
  q__list(args...; kw(kwargs)...)
end


function item(args...; kwargs...)
  q__item(args...; @kw(kwargs)...)
end


function item_section(args...; kwargs...)
  q__item__section(args...; @kw(kwargs)...)
end
const itemsection = item_section


function item_label(args...; kwargs...)
  q__item__label(args...; @kw(kwargs)...)
end
const itemlabel = item_label

end
