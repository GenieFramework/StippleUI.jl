module Badges

using Stipple, StippleUI

export BadgeModel

@reactive! mutable struct BadgeModel <: ReactiveModel
  myicon = "bluetooth"
end


function ui(badge_model)
  page(
    badge_model,
    title = "Badge Components",
    class = "q-pa-md q-gutter-md",
    [
      Html.div("Badge", class="text-h6", [
        badge("1.0.0+", color="primary")
      ])
    ]
  )
end

function factory()
  badge_model = BadgeModel |> init
  badge_model
end

end
