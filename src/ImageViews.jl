module ImageViews

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export imageview

register_normal_element("q__img", context = @__MODULE__)

function imageview(args...; kwargs...)
  q__img(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
end

end
