module ChatMessages

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template, register_normal_element

export chatmessage

register_normal_element("q__chat__message", context = @__MODULE__)

function chatmessage(text::Union{Symbol, String} = "",
                    args...; kwargs...)
  q__chat__message(args...; kw([:text => text, kwargs...])...)
end

end