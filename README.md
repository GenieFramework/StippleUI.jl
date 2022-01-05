# StippleUI

StippleUI is a library of reactive UI elements for [Stipple.jl](https://github.com/GenieFramework/Stipple.jl).

`StippleUI.jl`, together with [Stipple.jl](https://github.com/GenieFramework/Stipple.jl),
[StippleCharts.jl](https://github.com/GenieFramework/StippleCharts.jl) and
[Genie.jl](https://github.com/GenieFramework/Genie.jl) provide a powerful and complete solution for building
beautiful, responsive, reactive, high performance interactive data dashboards in pure Julia.

`StippleUI` provides over 30 UI elements, including forms and form inputs (button, slider, checkbox, radio, toggle, range), lists, data tables,
higher level components (badges, banners, cards, dialogs, chips, icons), and layout elements (row, col, dashboard, heading, space).

## Installation

```julia
pkg> add StippleUI
```

## Examples

### Checkboxes 

`checkbox` is a handy widget that one can use to give a user a list of options:

```julia
using Stipple, StippleUI

@reactive mutable struct Model <: ReactiveModel
  valone::R{Bool} = false
  valtwo::R{Bool} = false
  valthree::R{Bool} = false
end

function ui(my_model)
  page(
    my_model, class="container", [
      checkbox(label = "Apples", fieldname = :valone, dense = true),
      checkbox(label = "Bananas", fieldname = :valtwo, dense = true),
      checkbox(label = "Mangos", fieldname = :valthree, dense = true)
    ]
  )
end

my_model = Stipple.init(Model)

route("/") do 
  html(ui(my_model), context = @__MODULE__)
end
```

## Demos

### German Credits visualisation dashboard

<img src="https://genieframework.com/githubimg/Screenshot_German_Credits.png" width=800>

The full application is available at:
<https://github.com/GenieFramework/Stipple-Demo-GermanCredits>

### Iris Flowers dataset k-Means clustering dashboard

<img src="https://genieframework.com/githubimg/Screenshot_Iris_Data.png" width=800>

The full application is available at:
<https://github.com/GenieFramework/Stipple-Demo-IrisClustering>

## Acknowledgements

StippleUI builds upon the excellent Quasar Vue components <https://quasar.dev/vue-components>
