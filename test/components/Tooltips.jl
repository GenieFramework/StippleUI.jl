module Tooltips

using Stipple
using StippleUI

@reactive mutable struct TooltipModel <: ReactiveModel
  targetEl::R{String} = "#target-img-1"
end

function ui(tooltip_model)
  page(
    tooltip_model,
    title = "Tooltip Components",
    class = "container",
    [
      Html.div(class="q-pa-md", [
        Html.div(class="q-gutter-md", [
          btn("Hover me", color="primary", [
            tooltip("Some text as content of Tooltip")
          ]),

          Html.div(class="inline bg-amber rounded-borders cursor-pointer", style="max-width: 300px", [
            Html.div(class="fit flex flex-center text-center non-selectable q-pa-md", "I am groot!<br>(Hover me!)", [
              tooltip("I am groot!")
            ])
          ])
        ])
      ]),

      Html.div(class="q-pa-md q-gutter-md", [
        Html.div(class="row justify-center", [
          Html.div(class="row items-center q-gutter-x-sm", [
            radio("#target-img-1", :targetEl, val="#target-img-1"),
            radio("#target-img-2", :targetEl, val="#target-img-2")
          ])
        ]),

        Html.div(class="row justify-center", [
          imageview(src="https://cdn.quasar.dev/img/material.png", id="target-img-1", style="height: 100px", [
            Html.div("#target-img-1", class="absolute-bottom-right", style="border-top-left-radius: 5px"),
            # tooltip(target=:targetEl, anchor="center middle", self="center middle", contentclass="bg-black", "target1")
          ]),
          imageview(src="https://cdn.quasar.dev/img/parallax2.jpg", id="target-img-2", style="height: 100px", [
            Html.div("#target-img-2", class="absolute-bottom-right", style="border-top-left-radius: 5px"),
            # tooltip(target=:targetEl, anchor="center middle", self="center middle", contentclass="bg-black", "target2")
          ]),
        ])
      ])

    ]
  )
end

function factory()
  tooltip_model = TooltipModel |> init
  tooltip_model
end

end