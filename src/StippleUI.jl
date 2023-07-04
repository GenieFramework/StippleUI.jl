module StippleUI

import Genie
import Stipple

using Stipple.Reexport

const assets_config = Genie.Assets.AssetsConfig(package = "StippleUI.jl")

function deps_routes(; twbpatch::Bool = false) :: Nothing
  if ! Genie.Assets.external_assets(assets_config)
    Genie.Router.route(Genie.Assets.asset_route(assets_config, :css, file="quasar.min")) do
      Genie.Renderer.WebRenderable(
        Genie.Assets.embedded(Genie.Assets.asset_file(cwd=normpath(joinpath(@__DIR__, "..")), type="css", file="quasar.min")),
        :css) |> Genie.Renderer.respond
    end

    if twbpatch
      Genie.Router.route(Genie.Assets.asset_route(assets_config, :css, file="bootstrap-patch")) do
        Genie.Renderer.WebRenderable(
          Genie.Assets.embedded(Genie.Assets.asset_file(cwd=normpath(joinpath(@__DIR__, "..")), type="css", file="bootstrap-patch")),
          :css) |> Genie.Renderer.respond
      end
    end
  end

  if ! Genie.Assets.external_assets(assets_config)
    Genie.Router.route(Genie.Assets.asset_route(assets_config, :js, file="quasar.umd.min")) do
      Genie.Renderer.WebRenderable(
        Genie.Assets.embedded(Genie.Assets.asset_file(cwd=normpath(joinpath(@__DIR__, "..")), type="js", file="quasar.umd.min")),
        :javascript) |> Genie.Renderer.respond
    end
  end

  nothing
end

#===#

function theme(; twbpatch::Bool = false) :: Vector{String}
  [
    Stipple.Elements.stylesheet(Genie.Assets.asset_path(assets_config, :css, file="quasar.min")),
    (twbpatch ? Stipple.Elements.stylesheet(Genie.Assets.asset_path(assets_config, :css, file="bootstrap-patch")) : "")
  ]
end

#===#

function deps() :: Vector{String}
  [
    Genie.Renderer.Html.script(src="$(Genie.Assets.asset_path(assets_config, :js, file="quasar.umd.min"))")
  ]
end

#===#

include("API.jl")
include("PopupProxies.jl")
include("StippleUIParser.jl")

include("Avatars.jl")
include("Badges.jl")
include("Banners.jl")
include("BigNumbers.jl")
include("Buttons.jl")
include("Cards.jl")
include("ChatMessages.jl")
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
include("Notifications.jl")
include("Radios.jl")
include("Ranges.jl")
include("Ratings.jl")
include("ScrollAreas.jl")
include("Selects.jl")
include("Separators.jl")
include("Skeletons.jl")
include("Spaces.jl")
include("Spinners.jl")
include("Splitters.jl")
include("Tables.jl")
include("TabPanels.jl")
include("Tabs.jl")
include("Timelines.jl")
include("TimePickers.jl")
include("Toggles.jl")
include("Toolbars.jl")
include("Tooltips.jl")
include("Trees.jl")
include("Uploaders.jl")
include("Videos.jl")


#===#

import .API: quasar, quasar_pure, vue, vue_pure, xelem, xelem_pure, csscolors

export quasar, quasar_pure, vue, vue_pure, xelem, xelem_pure, csscolors

@reexport using .StippleUIParser

@reexport using .Avatars
@reexport using .Badges
@reexport using .Banners
@reexport using .BigNumbers
@reexport using .Buttons
@reexport using .Cards
@reexport using .ChatMessages
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
@reexport using .Ratings
@reexport using .PopupProxies
@reexport using .ScrollAreas
@reexport using .Selects
@reexport using .Separators
@reexport using .Skeletons
@reexport using .Spaces
@reexport using .Spinners
@reexport using .Splitters
@reexport using .QTables
const Tables = QTables
@reexport using .TabPanels
@reexport using .Tabs
@reexport using .Timelines
@reexport using .TimePickers
@reexport using .Toggles
@reexport using .Toolbars
@reexport using .Tooltips
@reexport using .Trees
@reexport using .Uploaders
@reexport using .Videos

export page_container # from Layouts

#===#

#===#

if !isdefined(Base, :get_extension)
  using Stipple.Requires
end

function __init__()
  deps_routes()
  push!(Stipple.Layout.THEMES, theme)
  Stipple.deps!(@__MODULE__, deps)

  @static if !isdefined(Base, :get_extension)
    @require DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0" begin
      # evaluate the code of the extension without the surrounding module
      include(joinpath(@__DIR__, "..", "ext", "StippleUIDataFrames.jl"))
    end
  end
end

end
