module Selects

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, select, template, register_normal_element

register_normal_element("q__select", context = @__MODULE__)

function select(fieldname::Symbol,
                args...;
                options::Symbol,
                kwargs...)

  q__select(args...; kw(
    [Symbol(":options") => options, :fieldname => fieldname, kwargs...])...)
end

end
