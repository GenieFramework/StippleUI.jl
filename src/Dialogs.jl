module Dialogs

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export dialog

register_normal_element("q__dialog", context = @__MODULE__)

function dialog(fieldname::Symbol, args...; kwargs...)
  q__dialog(args...; kw([:fieldname => fieldname, kwargs...])...)
end

# for compatibility reason with earlier versions
function dialog(args...; kwargs...)
  q__dialog(args...; kw(kwargs)...)
end

end
