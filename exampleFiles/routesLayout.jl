using Genie, Genie.Router, Genie.Renderer.Html
using StippleUI.Button, StippleUI.Layout

Base.@kwdef mutable struct Model <: ReactiveModel
  process::R{Bool} = false
  output::R{String} = ""
  input::R{String} = ""
end

model = Stipple.init(Model())

hier = string(Symbol("@click"),"=\"process = true\"")

on(model.process) do _
  if (model.process[])
    model.output[] = model.input[] |> reverse
    model.process[] = false
  end
end

function ui()
page(
  root(model), class="container", [
    StipplUI.Layout.layout(
      p([
        " Input "
        input("", @bind(:input), @on("keyup.enter", "process = true"))
      ])

      p([
        Button.button(label="Action!", click="process = true",color="primary")
      ])

      p([
        Html.button("Action!", click="process = true")
      ])

      p([
        " Output: "
        span("", @text(:output))
      ])
     )
    ]
  )|> html

end

route("/", ui)

up()
