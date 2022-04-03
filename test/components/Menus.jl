module Menus

using Stipple, StippleUI

export MenuModel

@reactive! mutable struct MenuModel <: ReactiveModel
end

function ui(menu_model)
  page(
    menu_model,
    title = "Menu Components",
    [
      btn("Basic Menu", color="primary", [
        StippleUI.menu(
          [p("Hello")]
          # list(style="min-width: 100px", [
          #   item(clickable=true, vclosepopup=true, [
          #     itemsection("New tab")
          #   ]),
          #   separator(),
          #   item(clickable=true, vclosepopup=true, [
          #     itemsection("New incognito tab")
          #   ]),
          #   separator(),
          #   item(clickable=true, vclosepopup=true, [
          #     itemsection("Recent tabs")
          #   ]),
          #   separator(),
          #   item(clickable=true, vclosepopup=true, [
          #     itemsection("History")
          #   ]),
          #   separator(),
          #   item(clickable=true, vclosepopup=true, [
          #     itemsection("Downloads")
          #   ]),
          #   separator(),
          #   item(clickable=true, vclosepopup=true, [
          #     itemsection("Settings")
          #   ]),
          #   separator(),
          #   item(clickable=true, vclosepopup=true, [
          #     itemsection("Help &amp; Feedback")
          #   ]),
          # ])
        # ]
        )
      ])
    ]
  )
end

function factory()
  menu_model = MenuModel |> init
  menu_model
end

end