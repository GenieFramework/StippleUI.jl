module Selects

using Stipple
using StippleUI

@reactive mutable struct SelectModel <: ReactiveModel
  model::R{Vector{String}} = []
  networks::R{Vector{String}} = ["Google", "Facebook", "Twitter", "Pinterest", "Reddit"]
end

function ui(select_model)
  page(
    select_model,
    title = "Select Components",
    class = "container",
    [
      # q-select filled v-model="model" :options="options" label="Filled" />
      select(:model, options= :networks, useinput=true, multiple=true, clearable = true, filled = true, counter = true,
      usechips = true, label="Social Networks")

      p("Values are: {{model}}")
    ],
  )
end

function factory()
  select_model = SelectModel |> init
  select_model
end

end