module Banners

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export banner

register_normal_element("q__banner", context = @__MODULE__)

function banner(content::String = "",
                args...;
                buttons::Vector{String} = String[],
                icon::Union{String,Nothing} = nothing,
                kwargs...)

  q__banner(args...; kw(kwargs)...) do
    string(
      (icon !== nothing ? Genie.Renderer.Html.template(()->icon, Symbol("v-slot:avatar")) : ""),
      content,
      (! isempty(buttons) ? Genie.Renderer.Html.template(()->join(buttons, "\n"), Symbol("v-slot:action")) : "")
    )
  end
end

end
