module Toggles

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template

export toggle

function __init__()
  Genie.Renderer.Html.register_normal_element("q__toggle", context = Genie.Renderer.Html)
end

function toggle(label::String = "",
                fieldname::Union{Symbol,Nothing} = nothing,
                args...;
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                kwargs...)
  wrap() do
    Genie.Renderer.Html.q__toggle(args...; attributes([:label => label, :fieldname => fieldname, kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

end
