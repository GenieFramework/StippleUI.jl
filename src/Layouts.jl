module Layouts

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export layout, pageContainer, page

register_normal_element("q__layout", context = @__MODULE__)
register_normal_element("q__page__container", context = @__MODULE__)
register_normal_element("q__page", context = @__MODULE__)


function layout(args...; kwargs...)
  q__layout(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
end

function page_container(args...; kwargs...)
  q__page__container(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
end

function page(args...; kwargs...)
  q__page(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
end


end
