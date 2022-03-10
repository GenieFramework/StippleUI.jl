module Spinners

using Stipple
using StippleUI

@reactive mutable struct SpinnerModel <: ReactiveModel
  box::R{String} = "box"
  comment::R{String} = "comment"
  hourglass::R{String} = "hourglass"
end

function ui(spinner_model)
  page(
    spinner_model,
    title = "Spinner Components",
    class = "container", [
      Html.div(class="q-pa-md", [
        Html.div(class="q-gutter-md row", [
          spinner(color="primary", size="3em")
          spinner(:box, color="orange",size="5.5em")
          spinner(:comment, color="green",size="3em")
          spinner(:hourglass, color="purple", size="4em")
        ])
      ])
    ]
  )
end

function factory()
  spinner_model = SpinnerModel |> init
  spinner_model
end

end