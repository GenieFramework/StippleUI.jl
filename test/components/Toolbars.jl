module Toolbars

using Stipple
using StippleUI

@reactive mutable struct ToolbarModel <: ReactiveModel
end

function ui(toolbar_model)
  page(
    toolbar_model,
    title = "Toolbar Components",
    class = "container",
    Html.div(class="q-pa-md q-gutter-y-sm", [
      toolbar(class="text-primary", [
        btn(flat=true, round=true, dense=true, icon="menu"),
        toolbartitle("Toolbar"),
        btn(flat=true, round=true, dense=true, icon="more_vert")
      ])
    ])
  )
end

function factory()
  toolbar_model = ToolbarModel |> init
  toolbar_model
end

end