using Documenter

push!(LOAD_PATH,  "../../src")

using StippleUI

makedocs(
    sitename = "SearchLight - Concise, secure, cross-platform query builder and ORM for Julia",
    format = Documenter.HTML(prettyurls = false),
    pages = [
        "Home" => "index.md",
        "StippleUI API" => [
          "API" => "api/API.md",
          "Avatars" => "api/avatars.md",
          "Badges" => "api/badges.md",
          "Banners" => "api/banners.md",
          "BigNumbers" => "api/bignumbers.md",
          "Buttons" => "api/buttons.md",
          "Cards" => "api/cards.md",
          "Checkboxes" => "api/checkboxes.md",
          "Chips" => "api/chips.md",
          "DatePickers" => "api/datepickers.md",
          "Dialogs" => "api/dialogs.md",
          "Drawers" => "api/drawers.md",
          "Editors" => "api/editors.md",
          "FormInputs" => "api/forminputs.md",
          "Forms" => "api/forms.md",
          "Headings" => "api/headings.md",
          "Icons" => "api/icons.md",
          "InnerLoaders" => "api/innerloaders.md",
          "Intersections" => "api/intersections.md",
          "Knobs" => "api/knobs.md",
          "Layouts" => "api/layouts.md",
          "Lists" => "api/lists.md",
          "Menus" => "api/menus.md",
          "PopupProxies" => "api/popupproxies.md",
          "Radios" => "api/radios.md",
          "Ranges" => "api/ranges.md",
          "Ratings" => "api/ratings.md",
          "ScrollAreas" => "api/scrollareas.md",
          "Selects" => "api/selects.md",
          "Separators" => "api/separators.md",
          "Skeletons" => "api/skeletons.md",
          "Spaces" => "api/spaces.md",
          "Spinners" => "api/spinners.md",
          "Splitters" => "api/splitters.md",
          "StippleUI" => "api/stippleui.md",
          "Tables" => "api/tables.md",
          "TabPanels" => "api/tabpanels.md",
          "Tabs" => "api/tabs.md",
          "Timelines" => "api/timelines.md",
          "Toggles" => "api/toggles.md",
          "Toolbars" => "api/toolbars.md",
          "Tooltips" => "api/tooltips.md",
          "Trees" => "api/trees.md",
          "Uploaders" => "api/uploaders.md",
          "Videos" => "api/videos.md",
        ]
    ],
)

deploydocs(
  repo = "github.com/GenieFramework/StippleUI.jl.git",
)
