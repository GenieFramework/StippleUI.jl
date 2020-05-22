module StippleQuasar

using Revise

import Genie
import Stipple

#===#

function theme() :: String
  Genie.Router.route("/css/stipple/quasar.min.css") do
    Genie.Renderer.WebRenderable(
      read(joinpath(@__DIR__, "..", "files", "css", "quasar.min.css"), String),
      :css) |> Genie.Renderer.respond
  end

  Stipple.Elements.stylesheet("/css/stipple/quasar.min.css")
end

#===#

function deps() :: String
  Genie.Router.route("/js/stipple/quasar.umd.min.js") do
    Genie.Renderer.WebRenderable(
      read(joinpath(@__DIR__, "..", "files", "js", "quasar.umd.min.js"), String),
      :javascript) |> Genie.Renderer.respond
  end

  Genie.Renderer.Html.script(src="/js/stipple/quasar.umd.min.js")
end

#===#

include("Table.jl")
include("Badge.jl")
include("Range.jl")
include("Checkbox.jl")

function __init__()
  push!(Stipple.Layout.THEMES, theme)
  push!(Stipple.DEPS, deps)
end

end