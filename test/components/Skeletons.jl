module Skeletons

using Stipple
using StippleUI

@reactive mutable struct SkeletonModel <: ReactiveModel
end

function ui(skeleton_model)
  page(
    skeleton_model,
    title = "Skeleton Components",
    class = "container",
    Html.div(class="q-pa-md", [
      card(style="max-width: 300px", [
        item([
          itemsection(avatar=true, [
            skeleton(type="QAvatar")
          ]),
          itemsection([
            itemlabel([ skeleton(type="text")]),
            itemlabel(caption=true, [ skeleton(type="text")])
          ])
        ]),

        skeleton(height="200px", square=true),

        cardactions(align="right", class="q-gutter-md",[
          skeleton(type="QBtn"),
          skeleton(type="QBtn")
        ])
      ])
    ])
  )
end

function factory()
  skeleton_model = SkeletonModel |> init
  skeleton_model
end

end