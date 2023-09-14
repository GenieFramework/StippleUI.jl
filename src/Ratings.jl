module Ratings

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export rating

register_normal_element("q__rating", context = @__MODULE__)

"""
    rating(fieldname::Union{Symbol,Nothing} = nothing,args...; kwargs...)

Rating is a Component which allows users to rate items, usually known as “Star Rating”.

----------
# Examples
----------

### Model

```julia-repl
julia> @vars RatingModel begin
          myrating::R{Int} = 3
       end

```

### View
```julia-repl
julia> rating(:myrating,size="1.5em",icon="thumb_up")
julia> rating(:myrating, size="2em",color="red-7",icon="favorite_border")
julia> rating(:myrating, size="2.5em", color="purple-4", icon="create")
```

----------
# Arguments
----------

1. Behaviour
      * `name::String` - Used to specify the name of the control; Useful if dealing with forms submitted directly to a URL `car_id`
2. Content
      * `icon::Union{String, Vector}` - Icon name; make sure you have the icon library installed unless you are using 'img:' prefix; If an array is provided each rating value will use the corresponding icon in the array (0 based) ex. `map` `ion-add` `img:https://cdn.quasar.dev/logo/svg/quasar-logo.svg` `img:path/to/some_image.png`
      * `iconselected::Union{String, Vector}` - Icon name to be used when selected (optional); make sure you have the icon library installed unless you are using 'img:' prefix; If an array is provided each rating value will use the corresponding icon in the array (0 based) ex. `map` `ion-add` `img:https://cdn.quasar.dev/logo/svg/quasar-logo.svg` `img:path/to/some_image.png`
      * `iconhalf::Union{String, Vector}` - Icon name to be used when selected (optional); make sure you have the icon library installed unless you are using 'img:' prefix; If an array is provided each rating value will use the corresponding icon in the array (0 based) ex. `map` `ion-add` `img:https://cdn.quasar.dev/logo/svg/quasar-logo.svg` `img:path/to/some_image.png`
3. Label
      * `max::Union{Int, String}` - Number of icons to display ex. `3` `max="5"`
4. Model
      * `noreset::Bool` - When used, disables default behavior of clicking/tapping on icon which represents current model value to reset model to 0
5. State
      * `readonly::Bool` - Put component in readonly mode
      * `disable::Bool` - Put component in disabled mode
6. Style
      * `size::String` - Size in CSS units, including unit name or standard size name (xs|sm|md|lg|xl) ex. `16px` `2rem` `md` `xs`
      * `color::Union{String, Vector}` - Color name for component from the [Color Palette](https://quasar.dev/style/color-palette); v1.5.0+: If an array is provided each rating value will use the corresponding color in the array (0 based) ex. `primary` `primary` `teal-10` `["accent", "grey-7"]`
      * `colorselected::Union{String, Vector}` - Color name from the Quasar Palette for selected icons `primary` `teal-10`
      * `colorhalf::Union{String, Vector}` - Color name from the [Color Palette](https://quasar.dev/style/color-palette) ex. `primary` `teal-10`
      * `nodimming::Bool` - Does not lower opacity for unselected icons
"""
function rating(fieldname::Union{Symbol,Nothing} = nothing,args...; kwargs...)
  q__rating(args...; kw([:fieldname => fieldname, kwargs...])...)
end

end
