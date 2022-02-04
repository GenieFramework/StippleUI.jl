module Cards

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export card, card_section, card_actions
export cardsection, cardactions

register_normal_element("q__card", context = @__MODULE__)
register_normal_element("q__card__section", context = @__MODULE__)
register_normal_element("q__card__actions", context = @__MODULE__)

function card(args...; kwargs...)
  q__card(args...; kwargs...)
end

function card_section(args...; kwargs...)
  q__card__section(args...; kwargs...)
end

const cardsection = card_section

function card_actions(args...; kwargs...)
  q__card__actions(args...; kwargs...)
end

const cardactions = card_actions

end
