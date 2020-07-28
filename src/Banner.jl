module Banner

using Revise

import Genie, Stipple
import Genie.Renderer.Html: HTMLString, normal_element, template_, div

using Stipple

export banner

Genie.Renderer.Html.register_normal_element("q__banner", context = @__MODULE__)

function banner(content::String = "",
                args...;
                buttons::Vector{String} = String[],
                icon::Union{String,Nothing} = nothing,
                kwargs...)

  template_() do
    q__banner(args...; kwargs...) do
      string(
        (icon !== nothing ? template_(()->icon, Symbol("v-slot:avatar")) : ""),
        content,
        (! isempty(buttons) ? template_(()->join(buttons, "\n"), Symbol("v-slot:action")) : "")
      )
    end
  end
end

end