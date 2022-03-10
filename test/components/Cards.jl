module Cards

using Stipple
using StippleUI

@reactive mutable struct CardModel <: ReactiveModel
  lorem::R{String} = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  url::R{String} = "https://cdn.quasar.dev/img/parallax2.jpg"
end

function ui(card_model)
  page(
    card_model,
    title = "Card Components",
    class = "container", 
    prepend = style(
    """
    .my-card{
      width: 100%;
      max-width: 250px;
    }
    """), 
    [
      Html.div(class="q-pa-md row items-start q-gutter-md", [
        card(class="my-card bg-secondary text-white", [
          card_section([
            Html.div("Our Changing Planet", class="text-h6"),
            Html.div("by John Doe", class="text-subtitle2")
          ]),
          card_section("{{ lorem }}"),
          card_actions([
            btn(flat=true, "Action 1"),
            btn(flat=true, "Action2")
          ])
        ]),
        card(class="my-card", [
          imageview(src=:url, basic=true, [
            Html.div("Title", class="absolute-bottom text-h6")
          ]),
          card_section("{{lorem}}")
        ])
      ])
    ]
  )
end

function factory()
  card_model = CardModel |> init
  card_model
end

end