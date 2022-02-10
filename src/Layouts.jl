module Layouts

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export layout, page_container, page

register_normal_element("q__layout", context = @__MODULE__)
register_normal_element("q__page__container", context = @__MODULE__)
register_normal_element("q__page", context = @__MODULE__)


function layout(args...; kwargs...)
  q__layout(args...; kw(kwargs)...)
end

function page_container(args...; kwargs...)
  q__page__container(args...; kw(kwargs)...)
end

function page(args...; kwargs...)
  q__page(args...; kw(kwargs)...)
end


end
