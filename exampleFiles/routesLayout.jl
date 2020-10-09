using Genie, Genie.Router, Genie.Renderer.Html, Stipple
using StippleUI.Button, StippleUI.Drawer

import StippleUI.Layout

Base.@kwdef mutable struct Model <: ReactiveModel
  process::R{Bool} = false
  output::R{String} = ""
  input::R{String} = ""
end

model = Stipple.init(Model())

on(model.process) do _
  if (model.process[])
    model.output[] = model.input[] |> reverse
    model.process[] = false
  end
end

function ui()
  page(
    root(model), class="container",
      [
         Layout.layout(view="lhh LpR lff",style="height: 500px", class="shadow-2 rounded-borders",[
              Drawer.drawer(showifabove="", side="left", bordered="", dashedwidth="200"  , [
                  p("Here comes the mouse :-)")
              ]),
              Layout.pageContainer([
                Layout.page(padding="",[
                    p([
                      "Input "
                      input("", @bind(:input), @on("keyup.enter", "process = true"))
                    ]),
                    p([
                      Button.button("Action!", click=("process = true"), color="primary")
                    ]),
                    p([
                      "Output: "
                      span("", @text(:output))
                    ])
                ])
              ])
          ])
     ]
  ) |> html
end

route("/", ui)

up()
