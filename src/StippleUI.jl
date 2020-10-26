module StippleUI

import Genie
import Stipple

using Stipple.Reexport

const DEFAULT_WRAPPER = Genie.Renderer.Html.template

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

include("API.jl")
include("Badge.jl")
include("Banner.jl")
include("BigNumber.jl")
include("Button.jl")
include("Card.jl")
include("Checkbox.jl")
include("Chip.jl")
include("Dashboard.jl")
include("Dialog.jl")
include("Form.jl")
include("FormInput.jl")
include("Heading.jl")
include("Icon.jl")
include("List.jl")
include("Radio.jl")
include("Range.jl")
include("Select.jl")
include("Separator.jl")
include("Space.jl")
include("Table.jl")
include("Toggle.jl")
############# new Elements ##################
include("Layout.jl")
include("Drawer.jl")


#===#

@reexport using .Badge
@reexport using .Banner
@reexport using .BigNumber
@reexport using .Button
@reexport using .Card
@reexport using .Checkbox
@reexport using .Chip
@reexport using .Dashboard
@reexport using .Dialog
@reexport using .Form
@reexport using .FormInput
@reexport using .Heading
@reexport using .Icon
@reexport using .List
@reexport using .Radio
@reexport using .Range
@reexport using .Select
@reexport using .Separator
@reexport using .Space
@reexport using .Table
@reexport using .Toggle

#===#

#===#

function __init__()
  push!(Stipple.Layout.THEMES, theme)
  push!(Stipple.DEPS, deps)
end

end
