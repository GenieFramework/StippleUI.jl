module StippleUI

import Genie
import Stipple

using Stipple.Reexport

const DEFAULT_WRAPPER = Genie.Renderer.Html.template
const NO_WRAPPER = f->f()

#===#

function theme(; twbpatch::Bool = true) :: String
  Genie.Router.route("/css/stipple/quasar.min.css") do
    Genie.Renderer.WebRenderable(
      read(joinpath(@__DIR__, "..", "files", "css", "quasar.min.css"), String),
      :css) |> Genie.Renderer.respond
  end

  if twbpatch
    Genie.Router.route("/css/stipple/twbpatch.css") do
      Genie.Renderer.WebRenderable(
        read(joinpath(@__DIR__, "..", "files", "css", "bootstrap-patch.css"), String),
        :css) |> Genie.Renderer.respond
    end
  end

  string(
    Stipple.Elements.stylesheet("$(Genie.config.base_path)css/stipple/quasar.min.css"),
    Stipple.Elements.stylesheet("$(Genie.config.base_path)css/stipple/twbpatch.css")
  )
end

#===#

function deps() :: String
  Genie.Router.route("/js/stipple/quasar.umd.min.js") do
    Genie.Renderer.WebRenderable(
      read(joinpath(@__DIR__, "..", "files", "js", "quasar.umd.min.js"), String),
      :javascript) |> Genie.Renderer.respond
  end

  Genie.Renderer.Html.script(src="$(Genie.config.base_path)js/stipple/quasar.umd.min.js")
end

#===#

include("API.jl")
include("PopupProxies.jl")

include("Badges.jl")
include("Banners.jl")
include("BigNumbers.jl")
include("Buttons.jl")
include("Cards.jl")
include("Checkboxes.jl")
include("Chips.jl")
include("Dashboards.jl")
include("DatePickers.jl")
include("Dialogs.jl")
include("Drawers.jl")
include("Editors.jl")
include("Forms.jl")
include("FormInputs.jl")
include("Headings.jl")
include("Icons.jl")
include("Intersections.jl")
include("Knobs.jl")
include("Layouts.jl")
include("Lists.jl")
include("Menus.jl")
include("Radios.jl")
include("Ranges.jl")
include("Selects.jl")
include("Separators.jl")
include("Spaces.jl")
include("Spinners.jl")
include("Tables.jl")
include("Toggles.jl")
include("Uploaders.jl")


#===#

import .API: quasar, quasar_pure, vue, vue_pure, xelem, xelem_pure, csscolors

export quasar, quasar_pure, vue, vue_pure, xelem, xelem_pure, @click, csscolors

@reexport using .PopupProxies

@reexport using .Badges
@reexport using .Banners
@reexport using .BigNumbers
@reexport using .Buttons
@reexport using .Cards
@reexport using .Checkboxes
@reexport using .Chips
@reexport using .Dashboards
@reexport using .DatePickers
@reexport using .Dialogs
@reexport using .Editors
@reexport using .Forms
@reexport using .FormInputs
@reexport using .Headings
@reexport using .Icons
@reexport using .Intersections
@reexport using .Knobs
@reexport using .Lists
@reexport using .Menus
@reexport using .Radios
@reexport using .Ranges
@reexport using .Selects
@reexport using .Separators
@reexport using .Spaces
@reexport using .Spinners
@reexport using .Tables
@reexport using .Toggles
@reexport using .Uploaders

#===#

"""
    `@click(expr)`

Defines a js routine that is called by a click of the quasar component.
If a symbol argument is supplied, `@click` sets this value to true.

`@click("savefile = true")` or `@click("myjs_func();")` or `@click(:button)`

Modifers can be appended:
```
@click(:me, :native)
# "v-on:click.native='me = true'"
```
"""
macro click(expr, mode="")
  quote
    x = $(esc(expr))
    m = $(esc(mode))
    if x isa Symbol
      """v-on:click$(m == "" ? "" : ".$m")='$x = true'"""
    else
      "v-on:click='$(replace(x, "'" => raw"\'"))'"
    end
  end
end

#===#

function __init__()
  push!(Stipple.Layout.THEMES, theme)
  push!(Stipple.DEPS, deps)
end

end
