module Separators

using Stipple, StippleUI

export SeparatorModel

@reactive! mutable struct SeparatorModel <: ReactiveModel
end

function ui(separator_model)
  page(
    separator_model,
    title = "Scroll area Components",
    [
      card(style="max-width: 250px", [
        cardsection(
          Html.div("Our Changing Planet", class="text-h6"),
          Html.div("by John Doe", class="text-subtitle2")
        ),
        cardsection("dLorem ipsum dolor sit amet, consectetur adipisicing elit.")
      ])
    ]
  )
end

function factory()
  separator_model = SeparatorModel |> init
  separator_model
end

end