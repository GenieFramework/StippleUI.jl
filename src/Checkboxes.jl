module Checkboxes

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export checkbox

register_normal_element("q__checkbox", context = @__MODULE__)

"""
The `checkbox` component is another basic element for user input. You can use this to supply a way for the user to toggle an option.

# Examples

```julia-repl
julia> checkbox(label = "Apples", fieldname = :valone, dense = true, size = "xl")
```

> Supported Props

# Label Props
-----------

| prop  | type  | Description | Examples |
|---|---|---|---|
| label  | String  | Label to display along the component (or use the default slot instead of this prop)  | `I agree with the Terms and Conditions`  |
| leftlabel | Bool | Label (if any specified) should be displayed on the left side of the component |  |

# Model Props
------------
| prop  | type  | Description | Examples |
|---|---|---|---|
| fieldname  | Symbol  | Model of the component  |  `false` `['car', 'building']` |
"""
function checkbox(label::String = "",
                  fieldname::Union{Symbol,Nothing} = nothing,
                  args...; kwargs...)

  q__checkbox(args...; kw([:label => label, :fieldname => fieldname, kwargs...])...)
end

end
