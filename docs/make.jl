using Documenter

push!(LOAD_PATH,  "../../src")

using StippleUI

makedocs(
    sitename = "SearchLight - Concise, secure, cross-platform query builder and ORM for Julia",
    format = Documenter.HTML(prettyurls = false),
    pages = [
        "Home" => "index.md",
        "StippleUI API" => [
          "API" => "API/API.md",
          "Avatars" => "API/avatars.md",
          "Badges" => "API/badges.md",
          "Banners" => "API/banners.md",
          "BigNumbers" => "API/bignumbers.md",
          "Buttons" => "API/buttons.md",
          "Cards" => "API/cards.md",
          "Checkboxes" => "API/checkboxes.md",
          "Chips" => "API/chips.md",
          "DatePickers" => "API/datepickers.md",
          "Dialogs" => "API/dialogs.md",
          "Drawers" => "API/drawers.md",
          "Editors" => "API/editors.md",
          "FormInputs" => "API/forminputs.md",
          "Forms" => "API/forms.md",
          "Headings" => "API/headings.md",
          "Icons" => "API/icons.md",
          "InnerLoaders" => "API/innerloaders.md",
          "Intersections" => "API/intersections.md",
          "Knobs" => "API/knobs.md",
          "Layouts" => "API/layouts.md",
          "Lists" => "API/lists.md",
          "Menus" => "API/menus.md",
          "PopupProxies" => "API/popupproxies.md",
          "Radios" => "API/radios.md",
          "Ranges" => "API/ranges.md",
          "Ratings" => "API/ratings.md",
          "ScrollAreas" => "API/scrollareas.md",
          "Selects" => "API/selects.md",
          "Separators" => "API/separators.md",
          "Skeletons" => "API/skeletons.md",
          "Spaces" => "API/spaces.md",
          "Spinners" => "API/spinners.md",
          "Splitters" => "API/splitters.md",
          "StippleUI" => "API/stippleui.md",
          "Tables" => "API/tables.md",
          "TabPanels" => "API/tabpanels.md",
          "Tabs" => "API/tabs.md",
          "Timelines" => "API/timelines.md",
          "Toggles" => "API/toggles.md",
          "Toolbars" => "API/toolbars.md",
          "Tooltips" => "API/tooltips.md",
          "Trees" => "API/trees.md",
          "Uploaders" => "API/uploaders.md",
          "Videos" => "API/videos.md",
        ]
    ],
)

deploydocs(
  repo = "github.com/GenieFramework/StippleUI.jl.git",
)
