using Genie, Stipple, StippleUI, Genie.Requests

@reactive! mutable struct FormModel <: ReactiveModel
  name::R{String} = ""
  age::R{Int} = 0
  warin::R{Bool} = true
end

function handlers(form_model)
  form_model
end

function ui(form_model)
  page(
    form_model,
    title = "Form Components",
    class = "q-pa-md",
    [
      StippleUI.form(action = "/sub", method = "POST", [
        textfield("What's your name *", :name, name = "name", @iif(:warin), :filled, hint = "Name and surname", "lazy-rules",
          rules = "[val => val && val.length > 0 || 'Please type something']"
        ),
        numberfield("Your age *", :age, name = "age", "filled", :lazy__rules,
          rules = "[val => val !== null && val !== '' || 'Please type your age',
            val => val > 0 && val < 100 || 'Please type a real age']"
        ),
        btn("submit", type = "submit", color = "primary")
      ])
    ]
  )
end

route("/") do
  init(FormModel) |> handlers |> ui |> html
end

route("/sub", method = "POST") do
  @info postpayload(:name)
  @info postpayload(:age)
  "Submitted"
end

up()