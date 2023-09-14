module Skeletons

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export skeleton

register_normal_element("q__skeleton", context = @__MODULE__)

"""
    skeleton(args...; kwargs...)

The `skeleton` is a component for displaying a placeholder preview of your content before you load the actual page data. It’s a nice way of informing the user of what to expect from the page before it is fully loaded and increases the perceived performance. It can be used to incrementally display information on screen as data is being fetched.

----------
# Examples
----------

### View
```julia-repl
julia> skeleton(type="QAvatar")
])
```

----------
# Arguments
----------

1. Content
      * `tag::String` - HTML tag to render. Defaults to `"div"`. Examples `"div"` `"span"`
      * `type::String` - Type of skeleton placeholder. Defaults to `"rect"`. Accepted values are `"rect"` `"circle"` `"QBadge"` `"QChip"` `"QRadio"` etc
2. Style
      * `dark::Bool` - Whether to use a dark skeleton.
      * `animation::String` - The animation effect of the skeleton placeholder. Defaults: `"wave"` | Examples. `"pulse"` `"fade"` `"blink"` `"none"` `"pulse-x"`
      * `square::Bool` - Removes border-radius so borders are squared
      * `bordered::Bool` - Applies a default border to the component
      * `size::String` - Size in CSS units, including unit name; Overrides 'height' and 'width' props and applies the value to both height and width
      * `width::String` - Width in CSS units, including unit name; Apply custom width; Use this prop or through CSS; Overridden by 'size' prop if used
      * `height::String` - Height in CSS units, including unit name; Apply custom height; Use this prop or through CSS; Overridden by 'size' prop if used. Examples `"16px"` `"2em"`
"""
function skeleton(args...; kwargs...)
  q__skeleton(args...; kw(kwargs)...)
end

end