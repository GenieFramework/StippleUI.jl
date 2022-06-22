module TabPanels

using Stipple
using StippleUI

@reactive mutable struct TabPanelModel <: ReactiveModel
  gpanel::R{String} = "panel"
end

function ui(tab_model)
  page(
    tabpanel_model,
    title = "TabPanel Components",
    class = "container",
    Html.div(class="q-pa-md", [
      Html.div(class="q-gutter-y-md", style="max-width: 350px", [
        tabpanelgroup(:gpanel, animated=true, swipeable=true, infinite=true,
          class="bg-purple text-white shadow-2 rounded-borders", [
          tabpanel("Lorem ipsum dolor sit amet consectetur
           adipisicing elit.", name="mails", [
            Html.div("Mails", class="text-h6")
          ]),
          
          tabpanel("Lorem ipsum dolor sit amet consectetur
           adipisicing elit.", name="alarms", [
            Html.div("Alarms", class="text-h6")
          ]),

          tabpanel("Lorem ipsum dolor sit amet consectetur
           adipisicing elit.", name="movies", [
            Html.div("Movies", class="text-h6")
          ]),
        ])
      ])
    ])
  )
end

function factory()
  tabpanel_model = TabPanelModel |> init
  tabpanel_model
end

end