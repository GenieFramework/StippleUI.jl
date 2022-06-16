module Tabs

using Stipple
using StippleUI

@reactive mutable struct TabModel <: ReactiveModel
  tab_m::R{String} = "tab"
end

function ui(tab_model)
  page(
    tab_model,
    title = "Tab Components",
    class = "container",
    Html.div(class="q-pa-md", [
      Html.div(class="q-gutter-y-md", style="max-width: 600px", [
        tabgroup(:tab_m, inlinelabel=true, class="bg-primary text-white shadow-2", [
          tab(name="photos", icon="photos", label="Photos"),
          tab(name="videos", icon="slow_motion_video", label="Videos"),
          tab(name="movies", icon="movie", label="Movies")
        ])
      ])
    ])
  )
end

function factory()
  tab_model = TabModel |> init
  tab_model
end

end