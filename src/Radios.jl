module Radios

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template

export radio

function __init__()
  Genie.Renderer.Html.register_normal_element("q__radio", context = Genie.Renderer.Html)
end

function radio( label::AbstractString = "",
                fieldname::Union{Symbol,Nothing} = nothing,
                args...;
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                kwargs...)
  wrap() do
    Genie.Renderer.Html.q__radio(args...; attributes([:label => label, :fieldname => fieldname, kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

end
