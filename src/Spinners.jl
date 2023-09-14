module Spinners

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export spinner

register_normal_element("q__spinner", context = @__MODULE__)

for spinner in ["audio", "ball", "bars", "box", "clock", "comment", "cube", "dots", "facebook", "gears", "grid",
                "hearts", "hourglass", "infinity", "ios", "orbit", "oval", "pie", "puff", "radio", "rings", "tail"]
  register_normal_element("q__spinner__$spinner", context = @__MODULE__)
end

"""
    spinner(spinner_type::Union{String,Symbol} = "", args...; kwargs...)

A `spinner` is used to show the user a timely process is currently taking place. It is an important UX feature, which gives the user the feeling the system is continuing to work for longer term activities, like grabbing data from the server or some heavy calculations.

----------
# Examples
----------

### Model

```julia-repl
julia> @vars SpinnerModel begin
          box::R{String} = "box"
          comment::R{String} = "comment"
          hourglass::R{String} = "hourglass"
       end
```

### View
```julia-repl
julia> spinner(color="primary", size="3em")
julia> spinner(:box, color="orange",size="5.5em")
julia> spinner(:comment, color="green",size="3em")
julia> spinner(:hourglass, color="purple", size="4em")
```

----------
# Arguments
----------

* `size::String` - Size in CSS units, including unit name or standard size name (xs|sm|md|lg|xl)  ex. `16px`  `2rem`  `xs` `md`
* `color::String` - Color name for component from the [Color Palette](https://quasar.dev/style/color-palette) ex. `primary` `teal`
* `thickness::Int` - Override value to use for stroke-width ex. `5`
"""
function spinner(spinner_type::Union{String,Symbol} = "",
                  args...;
                  kwargs...)

  getfield(@__MODULE__, Symbol("q__spinner$(isempty(string(spinner_type)) ? "" : "__")$spinner_type"))(args...; kw(kwargs)...)
end

end
