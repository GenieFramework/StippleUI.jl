module ExpansionItems

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export expansionitem

register_normal_element("q__expansion__item", context = @__MODULE__)

function expansionitem(args...; kwargs...)
  q__expansion__item(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
end

end
