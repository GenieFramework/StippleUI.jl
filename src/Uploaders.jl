module Uploaders

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export uploader

Genie.Renderer.Html.register_normal_element("q__uploader", context = @__MODULE__)

function uploader(args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              kwargs...)
  wrap() do
    q__uploader(args...; kwargs...)
  end
end

end
