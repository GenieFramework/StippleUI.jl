module StippleUI

import Genie
import Stipple

using Stipple.Reexport

const DEFAULT_WRAPPER = Genie.Renderer.Html.template
const NO_WRAPPER = f->f()

#===#

function theme() :: String
  Genie.Router.route("/css/stipple/quasar.min.css") do
    Genie.Renderer.WebRenderable(
      read(joinpath(@__DIR__, "..", "files", "css", "quasar.min.css"), String),
      :css) |> Genie.Renderer.respond
  end

  Stipple.Elements.stylesheet("$(Genie.config.base_path)css/stipple/quasar.min.css")
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
include("Badge.jl")
include("Banner.jl")
include("BigNumber.jl")
include("Button.jl")
include("Card.jl")
include("Checkbox.jl")
include("Chip.jl")
include("Dashboard.jl")
include("Dialog.jl")
include("Drawer.jl")
include("Editor.jl")
include("Form.jl")
include("FormInput.jl")
include("Heading.jl")
include("Icon.jl")
include("Intersection.jl")
include("Knob.jl")
include("Layout.jl")
include("List.jl")
include("Menu.jl")
include("Radio.jl")
include("Range.jl")
include("Select.jl")
include("Separator.jl")
include("Space.jl")
include("Spinner.jl")
include("Table.jl")
include("Toggle.jl")
include("Uploader.jl")


#===#

import .API: quasar, quasar_pure, vue, vue_pure, xelem, xelem_pure

export quasar, quasar_pure, vue, vue_pure, xelem, xelem_pure, @click

@reexport using .Badge
@reexport using .Banner
@reexport using .BigNumber
@reexport using .Button
@reexport using .Card
@reexport using .Checkbox
@reexport using .Chip
@reexport using .Dashboard
@reexport using .Dialog
@reexport using .Editor
@reexport using .Form
@reexport using .FormInput
@reexport using .Heading
@reexport using .Icon
@reexport using .Intersection
@reexport using .Knob
@reexport using .List
@reexport using .Menu
@reexport using .Radio
@reexport using .Range
@reexport using .Select
@reexport using .Separator
@reexport using .Space
@reexport using .Spinner
@reexport using .Table
@reexport using .Toggle
@reexport using .Uploader

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
