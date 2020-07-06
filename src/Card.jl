module Card

using Revise

import Genie, Stipple
import Genie.Renderer.Html: HTMLString, normal_element, template_

using Stipple

export card, card_section, card_actions

Genie.Renderer.Html.register_normal_element("q__card", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__card__section", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__card__actions", context = @__MODULE__)

function card(args...; kwargs...)
  template_() do
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