module Cards

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export card, card_section, card_actions

function __init__()
  Genie.Renderer.Html.register_normal_element("q__card", context = Genie.Renderer.Html)
  Genie.Renderer.Html.register_normal_element("q__card__section", context = Genie.Renderer.Html)
  Genie.Renderer.Html.register_normal_element("q__card__actions", context = Genie.Renderer.Html)
end

function card(args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              kwargs...)
  wrap() do
    Genie.Renderer.Html.q__card(args...; kwargs...)
  end
end

function card_section(args...; kwargs...)
  Genie.Renderer.Html.q__card__section(args...; kwargs...)
end

function card_actions(args...; kwargs...)
  Genie.Renderer.Html.q__card__actions(args...; kwargs...)
end

end
