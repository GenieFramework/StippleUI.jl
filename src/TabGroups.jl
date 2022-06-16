module TabGroups

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export tabgroup

register_normal_element("q__tabs", context = @__MODULE__)

"""
    tabgroup()
Renders a Qtabs layout element.
"""
function tabgroup(fieldname::Union{Symbol,Nothing} = nothing,
                  args...;
                  kwargs...)
  #q__tabs(args..; kw([:fieldname => fieldname, kwargs...])...)
  q__tabs(args...; attributes([:fieldname => fieldname, kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
end

end