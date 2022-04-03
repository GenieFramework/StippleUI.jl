module Scrollareas

using Stipple, StippleUI

export ScrollModel

@reactive! mutable struct ScrollModel <: ReactiveModel
end

function ui(scrollarea_model)
  page(
    scrollarea_model,
    title = "Scroll area Components",
    [
      StippleUI.scrollarea(style="height: 200px; max-width: 300px;", [
        Html.div("Stipple is a reactive UI library for building interactive 
        data applications in pure Julia. It uses Genie.jl (on the server side)
        and Vue.js (on the client). Stipple uses a high performance MVVM 
        architecture, which automatically synchronizes the state two-way
        (server -> client and client -> server) sending only JSON data over
        the wire. The Stipple package provides the fundamental communication
        layer, extending Genie's HTML API with a reactive component.")
      ])
    ]
  )
end

function factory()
  scrollarea_model = ScrollModel |> init
  scrollarea_model
end

end