module Lists

using Stipple, StippleUI

export ListModel

@reactive! mutable struct ListModel <: ReactiveModel
end

function ui(list_model)
  page(
    list_model,
    title = "List Components",
    [
      Html.div(class="q-pa-md", style="max-width: 350px", [
        list(bordered=true, separator=true, [
          item(clickable=true, vripple=true, [
            itemsection("Single line item")
          ]),

          item(clickable=true, vripple=true, [
            itemsection([
              itemlabel("Item with caption"),
              itemlabel("Caption", caption=true)
            ])
          ]),

          item(clickable=true, vripple=true, [
            itemsection([
              itemlabel("OVERLINE", overline=true),
              itemlabel("Item with caption")
            ])
          ]),
        ])
      ])
    ]
  )
end

function factory()
  list_model = ListModel |> init
  list_model
end

end