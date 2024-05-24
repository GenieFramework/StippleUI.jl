module Toggles

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template, register_normal_element

export toggle

register_normal_element("q__toggle", context = @__MODULE__)

"""
    toggle(label::Union{String,Symbol}, fieldname::Union{Symbol,Nothing}, args...; kwargs...)

The `toggle` component is another basic element for user input. You can use this for turning settings, features or true/false inputs on and off.

----------
### Examples
----------

### Model

```julia-repl
julia> @vars ToggleModel begin
          value::R{Bool} = false
          selection::R{Vector{String}} = ["yellow", "red"]
       end
```

### View
```julia-repl
julia> toggle("Blue", color="blue", :selection, val="blue")
julia> toggle("Yellow", color="yellow", :selection, val="yellow")
julia> toggle("Green", color="green", :selection, val="green")
julia> toggle("Red", color="red", :selection, val="red")
```

----------
### Arguments
----------

1. Behaviour
      * `name::String` - Used to specify the name of the control; Useful if dealing with forms submitted directly to a URL ex. `"car_id"`
      * `indeterminatevalue::Union{Int, Float64, String, Bool}` - What model value should be considered as 'indeterminate'? default value: `null` ex. `0` `"not_answered"`
      * `toggleorder::String` - Determines toggle order of the two states ('t' stands for state of true, 'f' for state of false); If 'toggle-indeterminate' is true, then the order is: indet -> first state -> second state -> indet (and repeat), otherwise: indet -> first state -> second state -> first state -> second state -> ... default `"tf"` ex. `"tf"` `"ft"`
      * `toggleindeterminate::Bool` - When user clicks/taps on the component, should we toggle through the indeterminate state too?
      * `keepcolor::Bool` - Should the color (if specified any) be kept when the component is unticked/ off?
2. Content
      * `icon::String` - Icon name following Quasar convention; Make sure you have the icon library installed unless you are using 'img:' prefix; If 'none' (String) is used as value then no icon is rendered (but screen real estate will still be used for it) ex. `map` `ion-add` `img:https://cdn.quasar.dev/logo/svg/quasar-logo.svg` `img:path/to/some_image.png`
      * 
3. General
      * `tabindex::Union{Int, String}` - Tabindex HTML attribute value `0` `100`
4. Icons
      * `checkedicon::String` - The icon to be used when the toggle is on ex. `visibility`
      * `uncheckedicon::String` - The icon to be used when the toggle is off ex. `visibility-off`
      * `indeterminateicon::String` - The icon to be used when the model is indeterminate ex. `help`
5. Label
      * `label::Union{String,Symbol}` - Label to display along the component ex. `I agree to terms and conditions`
      * `leftlabel::Bool` - Label (if any specified) should be displayed on the left side of the component
6. Model
      * `val::Union{Bool, Int, Float64, String, Vector}` - Works when model ('value') is Array. It tells the component which value should add/remove when ticked/unticked ex. `car`
      * `truevalue::Union{Bool, Int, Float64, String, Vector}` - What model value should be considered as checked/ticked/on? default `true` ex. `Agreed`
      * `falsevalue::Union{Bool, Int, Float64, String, Vector}` - What model value should be considered as unchecked/unticked/off? default `false` ex. `Not agreed`
7. State
      * `disabled::Bool` - Put component in disabled mode
8. style
      * `size::String` - Size in CSS units, including unit name or standard size name (xs|sm|md|lg|xl) ex. `16px` `1.5rem` `xs` `md`
      * `color::String` - Color name for component from the [Color Palette](https://quasar.dev/style/color-palette) ex. `primary` `teal-10`
      * `dark::Bool` - Notify the component that the background is a dark color
      * `dense::Bool` - Dense mode; occupies less space
      * `iconcolor` - Override default icon color (for truthy state only); Color name for component from the [Color Palette](https://quasar.dev/style/color-palette) ex. `primary` `teal-10`
"""
function toggle(label::Union{String,Symbol} = "",
                fieldname::Union{Symbol,Nothing} = nothing,
                args...;
                kwargs...)

  q__toggle(args...; kw([:label => label, :fieldname => fieldname, kwargs...])...)
end

end
