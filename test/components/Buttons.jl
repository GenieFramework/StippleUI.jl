module Buttons

using Stipple, StippleUI

export ButtonModel

@reactive! mutable struct ButtonModel <: ReactiveModel
  press_btn::R{Bool} = false
  first_item::R{Bool} = false
  second_item::R{Bool} = false
  third_item::R{Bool} = false
end

function handlers(button_model)
  onbutton(button_model.press_btn) do
    @info "Character Moving Left"
  end

  onbutton(button_model.first_item) do
    @info "spain item selected"
  end

  onbutton(button_model.second_item) do
    @info "USA item selected"
  end

  onbutton(button_model.third_item) do
    @info "Netherlands item selected"
  end

  button_model
end

function ui(button_model)
  page(
    button_model,
    title = "Button Components",
    class = "q-pa-md q-gutter-sm",
    [
      btn("Move Left", color = "primary", icon = "mail", @click("press_btn = true")),
      btn("Go to Hello World", color = "red", type = "a", href = "hello", icon = "map", iconright = "send"),
      btndropdown(label = "Dropdown Button", color = "primary", [
        list([
          item("Spain", clickable = true, vclosepopup = true, @click("first_item = true")),
          item("USA", clickable = true, vclosepopup = true, @click("second_item = true")),
          item("Netherlands", clickable = true, vclosepopup = true, @click("third_item = true"))
        ]),
      ])
    ]
  )
end

function factory()
  buttonmodel = ButtonModel |> init |> handlers |> ui
  buttonmodel
end

# route("/") do
#   init(ButtonModel) |> handlers |> ui |> html
# end

# route("/hello") do
#   "Hello World"
# end

# up(9002, async = false)

end