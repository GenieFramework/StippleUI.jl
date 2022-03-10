module Ratings

using Stipple
using StippleUI

@reactive mutable struct RatingModel <: ReactiveModel
  myrating::R{Int} = 3
end

function ui(rating_model)
  page(
    rating_model,
    title = "Rating Components",
    class = "container",
    Html.div(class="q-pa-md", [
      Html.div(class="q-gutter-y-md column", [
        rating(:myrating,size="1.5em",icon="thumb_up",),
        rating(:myrating, size="2em",color="red-7",icon="favorite_border"),
        rating(:myrating, size="2.5em", color="purple-4", icon="create")
      ])
    ])
  )
end

function factory()
  rating_model = RatingModel |> init
  rating_model
end

end