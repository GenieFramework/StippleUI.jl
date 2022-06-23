module Splitters

using Stipple
using StippleUI

@reactive mutable struct SplitterModel <: ReactiveModel
  splitterM::R{Int} = 50
end

function ui(splitter_model)
  page(
    splitter_model,
    title = "Tab Components",
    class = "container",
    Html.div([
      splitter(:splitterM, style="height: 400px", [
        template("", "v-slot:before", [
          Html.div(class="q-pa-md", [
            Html.div("Before", class="text-h4 q-mb-md"),
            Html.div("{{ n }}. Lorem ipsum dolor sit, amet consectetur adipisicing elit.
               Quis praesentium cumque magnam odio iure quidem, quod illum numquam possimus
               obcaecati commodi minima assumenda consectetur culpa fuga nulla ullam. In, libero.",
              class = "q-my-md",
              @recur(:"n in 20"), key! = "n")
          ])
        ]),
        template("", "v-slot:after", [
          Html.div(class="q-pa-md", [
            Html.div("After", class="text-h4 q-mb-md")
              Html.div("{{ n }}. Lorem ipsum dolor sit, amet consectetur adipisicing elit.
               Quis praesentium cumque magnam odio iure quidem, quod illum numquam possimus
               obcaecati commodi minima assumenda consectetur culpa fuga nulla ullam. In, libero.",
              class = "q-my-md",
              @recur(:"n in 20"), key! = "n")
          ])
        ])
      ])
    ])
  )
end

function factory()
  splitter_model = SplitterModel |> init
  splitter_model
end

end