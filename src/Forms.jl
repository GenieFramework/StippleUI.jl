module Forms

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export form

register_normal_element("q__form", context = @__MODULE__)

function form(args...; noresetfocus::Bool = false, kwargs...)
  q__form(args...; kw(kwargs)...)
end

end
