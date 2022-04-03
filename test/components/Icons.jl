module Icons

using Stipple, StippleUI

export IconModel

@reactive! mutable struct IconModel <: ReactiveModel
end

function ui(icon_model)
  page(
    icon_model,
    title = "Icon Components",
    class = "q-pa-md q-gutter-sm",
    [
      icon("font_download", class="text-primary", style="font-size: 32px;"),
      icon("warning", class="text-red", style="font-size:4rem;"),
      icon("format_size", style="color: #ccc; font-size: 1.4em;"),
      icon("print", class="text-teal", style="font-size: 4.4em;"),
      icon("today", class="text-orange", style="font-size: 2em;"),
      icon("style", style="font-size: 3em;"),
    ]
  )
end

function factory()
  icon_model = IconModel |> init
  icon_model
end

end