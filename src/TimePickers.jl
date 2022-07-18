module TimePickers

using Genie, Stipple, StippleUI, StippleUI.API
using Dates

import Genie.Renderer.Html: HTMLString, normal_element, template, register_normal_element

export timepicker

register_normal_element("q__time", context= @__MODULE__)

# The default model mask is HH:mm (or HH:mm:ss when using with-seconds prop), however you can use custom masks too.

function timepicker(fieldname::Union{Symbol,Nothing} = nothing,
                    args...;
                    kwargs...)
    q__time(args...; kw([:fieldname => fieldname, kwargs...])...)
end

end