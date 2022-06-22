module Steppers

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export  step, stepper, steppernavigation

register_normal_element("q__stepper", context = @__MODULE__)
register_normal_element("q__step", context = @__MODULE__)
register_normal_element("q__stepper__navigation", context = @__MODULE__)

"""
    stepper(fieldname::Symbol, args...; kwargs...)


----------
# Examples
----------

### View
```julia-repl
julia> 
])
```

----------
# Arguments
----------

1. Behaviour
      * 
"""
function stepper(fieldname::Symbol, args...; kwargs...)
  q__stepper(args...; kw([:fieldname => fieldname, kwargs...])...)
end


"""
    step(args...; kwargs...)


----------
# Examples
----------

### View
```julia-repl
julia> 
])
```

----------
# Arguments
----------

1. Behaviour
      * 
"""
function step(args...; kwargs...)
  q__step(args...; kw(kwargs)...)
end

"""
    steppernavigation(args...; kwargs...)


----------
# Examples
----------

### View
```julia-repl
julia> 
])
```

----------
# Arguments
----------

1. Behaviour
      * 
"""
function steppernavigation(args...; kwargs...)
  q__stepper__navigation(args...; kw(kwargs)...)
end

end
