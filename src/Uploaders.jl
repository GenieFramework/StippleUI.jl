module Uploaders

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export uploader

function __init__()
  Genie.Renderer.Html.register_normal_element("q__uploader", context = Genie.Renderer.Html)
end

function uploader(args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              kwargs...)
  wrap() do
    Genie.Renderer.Html.q__uploader(args...; kwargs...)
  end
end

end
