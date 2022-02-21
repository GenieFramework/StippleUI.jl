using Stipple, StippleUI

@reactive! mutable struct ButtonModel <: ReactiveModel
  primary::R{Bool} = false
end

function handlers(button_model)
  on(button_model.primary) do primary
    primary || return
    @info "Button Clicked"
    primary[] = false
  end
  button_model
end

function ui(button_model)
    page(button_model, title="Button Components", class="q-pa-md q-gutter-sm", [
      btn(color="primary", icon="mail", label="On Left", @click("primary = !primary"))
      btn(color="secondary", iconright="mail", label="On Right")
      btn(color="red", icon="mail", iconright="send", label="On Left and Right")
    ])
end

route("/") do
  init(ButtonModel) |> handlers |> ui |> html
end

up()