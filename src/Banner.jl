module Banner

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export banner

Genie.Renderer.Html.register_normal_element("q__banner", context = @__MODULE__)

function banner(content::String = "",
                args...;
                buttons::Vector{String} = String[],
                icon::Union{String,Nothing} = nothing,
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                kwargs...)

  wrap() do
    q__banner(args...; kwargs...) do
      string(
        (icon !== nothing ? wrap(()->icon, Symbol("v-slot:avatar")) : ""),
        content,
        (! isempty(buttons) ? wrap(()->join(buttons, "\n"), Symbol("v-slot:action")) : "")
      )
    end
  end
end

end
