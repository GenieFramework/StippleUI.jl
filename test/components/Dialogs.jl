module Dialogs

using Stipple
using StippleUI

@reactive mutable struct DialogModel <: ReactiveModel
  show_dialog::R{Bool} = false
end

function handlers(dialog_model)
  onbutton(button_model.btnConnect) do
    @info "Showing card dialog"
  end
  dialog_model
end

function ui(dialog_model)
  page(
    dialog_model,
    title = "Dialog Components",
    class = "container",
    [
      Html.div(class="q-pa-md q-gutter-sm", [
        btn("Alert", color="primary", @click("show_dialog = true")),
        StippleUI.dialog(:show_dialog, [
          card([
            card_section(Html.div(class="text-h6", "Alert")),
            card_section(class="q-pt-none", "Lorem ipsum dolor sit amet consectetur adipisicing elit. 
            Rerum repellendus sit voluptate voluptas eveniet porro. Rerum blanditiis perferendis totam, 
            ea at omnis vel numquam exercitationem aut, natus minima, porro labore.")
          ])
        ])
      ])
    ]
  )
end

function factory()
  dialog_model = DialogModel |> init
  dialog_model
end

end