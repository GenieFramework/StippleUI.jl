module Chips

using Stipple, StippleUI

export ChipModel

@reactive! mutable struct ChipModel <: ReactiveModel
end

function ui(chip_model)
  page(
    chip_model,
    title = "Chips Components",
    class = "q-pa-md q-gutter-sm",
    [
      chip("Add to calendar", icon="event"),
    ]
  )
end

function factory()
  chip_model = ChipModel |> init |> handlers
  chip_model
end

end
