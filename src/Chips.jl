module Chips

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export chip

register_normal_element("q__chip", context = @__MODULE__)

function chip(args...; kwargs...)
  q__chip(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
end

end
