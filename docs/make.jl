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
          "Badges" => "api/badges.md",
          "Banners" => "api/banners.md",
          "BigNumbers" => "api/bignumbers.md",
          "Buttons" => "api/buttons.md",
          "Cards" => "api/cards.md",
          "Checkboxes" => "api/checkboxes.md",
          "Chips" => "api/chips.md",
          "Dashboards" => "api/dashboards.md",
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
          "ScrollAreas" => "api/scrollareas.md",
          "Selects" => "api/selects.md",
          "Separators" => "api/separators.md",
          "Spaces" => "api/spaces.md",
          "Spinners" => "api/spinners.md",
          "StippleUI" => "api/stippleui.md",
          "Tables" => "api/tables.md",
          "Toggles" => "api/toggles.md",
          "Uploaders" => "api/uploaders.md",
        ]
    ],
)

deploydocs(
  repo = "github.com/GenieFramework/StippleUI.jl.git",
)
