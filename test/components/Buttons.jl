using Stipple, StippleUI

@reactive! mutable struct ButtonModel <: ReactiveModel
  press_btn::R{Bool} = false
end

function handlers(button_model)
  on(button_model.press_btn) do press_btn
    press_btn || return
    @info "pressed"
    button_model.press_btn[] = false
  end
  button_model
end

function ui(button_model)
  page(
    button_model,
    title = "Button Components",
    class = "q-pa-md q-gutter-sm",
    [
      btn("On Left", color = "primary", icon = "mail", @click("press_btn = true")),
      btn("Go to Hello World", color = "red", href = "/hello", icon = "map", iconright = "send")
    ]
  )
end

route("/") do
  init(ButtonModel) |> handlers |> ui |> html
end

route("/hello") do
  "Hello World"
end

up()