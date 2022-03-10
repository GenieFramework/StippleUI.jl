module Buttons

using Stipple, StippleUI

export ButtonModel

@reactive! mutable struct ButtonModel <: ReactiveModel
  press_btn::R{Bool} = false
  first_item::R{Bool} = false
  second_item::R{Bool} = false
  third_item::R{Bool} = false
  btnConnect::R{Bool} = false
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

  onbutton(button_model.btnConnect) do
    @info "Connecting to server"
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
      ]),
      btn("Connect to server!", color="green", textcolor="black", @click("btnConnect=!btnConnect"), [
          tooltip(contentclass="bg-indigo", contentstyle="font-size: 16px", 
          style="offset: 10px 10px",  "Ports bounded to sockets!")]
      )
    ]
  )
end

function factory()
  buttonmodel = ButtonModel |> init |> handlers
  buttonmodel
end

end


# route("/") do
#   init(ButtonModel) |> handlers |> ui |> html
# end

# route("/hello") do
#   "Hello World"
# end

# up(async=false)
