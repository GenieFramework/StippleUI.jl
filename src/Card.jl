module Card

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export card, card_section, card_actions

Genie.Renderer.Html.register_normal_element("q__card", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__card__section", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__card__actions", context = @__MODULE__)

function card(args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              kwargs...)
  wrap() do
    q__card(args...; kwargs...)
  end
end

function card_section(args...; kwargs...)
  q__card__section(args...; kwargs...)
end

function card_actions(args...; kwargs...)
  q__card__actions(args...; kwargs...)
end

end
