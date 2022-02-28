module StippleUI

import Genie
import Stipple

using Stipple.Reexport

const assets_config = Genie.Assets.AssetsConfig(package = "StippleUI.jl")

#===#

function theme(; twbpatch::Bool = false) :: Vector{String}
  if ! Genie.Assets.external_assets(assets_config)
    Genie.Router.route(Genie.Assets.asset_path(assets_config, :css, file="quasar.min")) do
      Genie.Renderer.WebRenderable(
        Genie.Assets.embedded(Genie.Assets.asset_file(cwd=normpath(joinpath(@__DIR__, "..")), type="css", file="quasar.min")),
        :css) |> Genie.Renderer.respond
    end

    if twbpatch
      Genie.Router.route(Genie.Assets.asset_path(assets_config, :css, file="bootstrap-patch")) do
        Genie.Renderer.WebRenderable(
          Genie.Assets.embedded(Genie.Assets.asset_file(cwd=normpath(joinpath(@__DIR__, "..")), type="css", file="bootstrap-patch")),
          :css) |> Genie.Renderer.respond
      end
    end
  end

  [
    Stipple.Elements.stylesheet(Genie.Assets.asset_path(assets_config, :css, file="quasar.min")),
    (twbpatch ? Stipple.Elements.stylesheet(Genie.Assets.asset_path(assets_config, :css, file="bootstrap-patch")) : "")
  ]
end

#===#

function deps() :: Vector{String}
  if ! Genie.Assets.external_assets(assets_config)
    Genie.Router.route(Genie.Assets.asset_path(assets_config, :js, file="quasar.umd.min")) do
      Genie.Renderer.WebRenderable(
        Genie.Assets.embedded(Genie.Assets.asset_file(cwd=normpath(joinpath(@__DIR__, "..")), type="js", file="quasar.umd.min")),
        :javascript) |> Genie.Renderer.respond
    end
  end

  [
    Genie.Renderer.Html.script(src="$(Genie.Assets.asset_path(assets_config, :js, file="quasar.umd.min"))")
  ]
end

#===#

include("API.jl")
include("PopupProxies.jl")

include("Avatars.jl")
include("Badges.jl")
include("Banners.jl")
include("BigNumbers.jl")
include("Buttons.jl")
include("Cards.jl")
include("Checkboxes.jl")
include("Chips.jl")
include("DatePickers.jl")
include("Dialogs.jl")
include("Drawers.jl")
include("Editors.jl")
include("ExpansionItems.jl")
include("Forms.jl")
include("FormInputs.jl")
include("Headings.jl")
include("Icons.jl")
include("ImageViews.jl")
include("InnerLoaders.jl")
include("Intersections.jl")
include("Knobs.jl")
include("Layouts.jl")
include("Lists.jl")
include("Menus.jl")
include("Radios.jl")
include("Ranges.jl")
include("ScrollAreas.jl")
include("Selects.jl")
include("Separators.jl")
include("Spaces.jl")
include("Spinners.jl")
include("Tables.jl")
include("Toggles.jl")
include("Tooltips.jl")
include("Uploaders.jl")


#===#

import .API: quasar, quasar_pure, vue, vue_pure, xelem, xelem_pure, csscolors

export quasar, quasar_pure, vue, vue_pure, xelem, xelem_pure, @click, csscolors


@reexport using .Avatars
@reexport using .Badges
@reexport using .Banners
@reexport using .BigNumbers
@reexport using .Buttons
@reexport using .Cards
@reexport using .Checkboxes
@reexport using .Chips
@reexport using .DatePickers
@reexport using .Dialogs
@reexport using .Drawers
@reexport using .Editors
@reexport using .ExpansionItems
@reexport using .Forms
@reexport using .FormInputs
@reexport using .Headings
@reexport using .Icons
@reexport using .ImageViews
@reexport using .InnerLoaders
@reexport using .Intersections
          using .Layouts
@reexport using .Knobs
@reexport using .Lists
@reexport using .Menus
@reexport using .Radios
@reexport using .Ranges
@reexport using .PopupProxies
@reexport using .ScrollAreas
@reexport using .Selects
@reexport using .Separators
@reexport using .Spaces
@reexport using .Spinners
@reexport using .Tables
@reexport using .Toggles
@reexport using .Tooltips
@reexport using .Uploaders

export page_container # from Layouts

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
  Stipple.DEPS[@__MODULE__] = deps
end

end
