module Forms

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export form

register_normal_element("q__form", context = @__MODULE__)

"""
    form(args...; noresetfocus::Bool = false, kwargs...)
  
The `form` component renders a <form> DOM element and allows you to easily validate child form components (like `input`, `select` or your `field` wrapped components) that have the internal validation (NOT the external one) through rules associated with them.

----------
# Examples
----------

### Model

```julia-repl
julia> @reactive! mutable struct FormModel <: ReactiveModel
          name::R{String} = ""
          age::R{Int} = 0
          warin::R{Bool} = true
       end
```

### View
```julia-repl
julia> StippleUI.form(action = "/sub", method = "POST", [
          textfield("What's your name *", :name, name = "name", @iif(:warin), :filled, hint = "Name and surname", "lazy-rules",
            rules = "[val => val && val.length > 0 || 'Please type something']"
          ),
          numberfield("Your age *", :age, name = "age", "filled", :lazy__rules,
            rules = "[val => val !== null && val !== '' || 'Please type your age',
              val => val > 0 && val < 100 || 'Please type a real age']"
          ),
          btn("submit", type = "submit", color = "primary")
       ])
```

----------
# Arguments
----------

* `autofocus::Bool` - Focus first focusable element on initial component render
* `noerrorfocus::Bool` - Do not try to focus on first component that has a validation error when submitting form
* `noresetfocus::Bool` - Do not try to focus on first component when resetting form
* `greedy::Bool` - Validate all fields in form (by default it stops after finding the first invalid field with synchronous validation)
"""
function form(args...; noresetfocus::Bool = false, kwargs...)
  q__form(args...; kw(kwargs)...)
end

end
