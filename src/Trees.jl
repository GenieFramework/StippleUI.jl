module Trees

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export tree

register_normal_element("q__tree", context = @__MODULE__)

function tree(args...; kwargs...)
  q__tree(args...; kw(kwargs)...)
end

end