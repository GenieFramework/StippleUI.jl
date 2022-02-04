module Radios

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template, register_normal_element

export radio

register_normal_element("q__radio", context = @__MODULE__)

function radio( label::AbstractString = "",
                fieldname::Union{Symbol,Nothing} = nothing,
                args...;
                kwargs...)
  q__radio(args...; attributes([:label => label, :fieldname => fieldname, kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
end

end
