module Selects

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, select, template

function __init__()
  Genie.Renderer.Html.register_normal_element("q__select", context = Genie.Renderer.Html)
end

function Genie.Renderer.Html.select(fieldname::Symbol,
                args...;
                options::Symbol,
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                kwargs...)

  wrap() do
    Genie.Renderer.Html.q__select(args...; attributes(
      [Symbol(":options") => options, :fieldname => fieldname, kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

end
