module Uploaders

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export uploader

register_normal_element("q__uploader", context = @__MODULE__)

function uploader(args...; kwargs...)
  q__uploader(args...; kw(kwargs)...)
end

end
