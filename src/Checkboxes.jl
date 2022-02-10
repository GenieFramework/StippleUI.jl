module Checkboxes

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export checkbox

register_normal_element("q__checkbox", context = @__MODULE__)

function checkbox(label::String = "",
                  fieldname::Union{Symbol,Nothing} = nothing,
                  args...; kwargs...)

  q__checkbox(args...; kw([:label => label, :fieldname => fieldname, kwargs...])...)
end

end
