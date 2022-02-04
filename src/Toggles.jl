module Toggles

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template, register_normal_element

export toggle

register_normal_element("q__toggle", context = @__MODULE__)

function toggle(label::String = "",
                fieldname::Union{Symbol,Nothing} = nothing,
                args...;
                kwargs...)

  q__toggle(args...; attributes([:label => label, :fieldname => fieldname, kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
end

end
