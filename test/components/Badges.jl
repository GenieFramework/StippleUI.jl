module Badges

using Stipple, StippleUI

export BadgeModel

@reactive! mutable struct BadgeModel <: ReactiveModel
end


function ui(badge_model)
  page(
    badge_model,
    title = "Badge Components",
    class = "q-pa-md q-gutter-md",
    [
      badge(color="orange", textcolor="black", label="2")
    ]
  )
end

function factory()
  badgemodel = BadgeModel |> init
  badgemodel
end

end
