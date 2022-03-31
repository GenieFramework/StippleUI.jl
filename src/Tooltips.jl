module Tooltips

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export tooltip

register_normal_element("q__tooltip", context = @__MODULE__)

"""
    tooltip(args...; kwargs...)
"""
function tooltip(args...; kwargs...)
  q__tooltip(args...; kw(kwargs)...)
end

"""
    tooltip(fieldname::Symbol, args...; kwargs...)

The `tooltip` component is to be used when you want to offer the user more information
about a certain area in your App. When hovering the mouse over the target element
(or quickly tapping on mobile platforms), the tooltip will appear.

----------
# Examples
----------

### View
```julia-repl
julia> btn("Hover me", color="primary", [
          tooltip("Some text as content of Tooltip")
       ])
julia> Html.div(class="inline bg-amber rounded-borders cursor-pointer", style="max-width: 300px", [
          Html.div(class="fit flex flex-center text-center non-selectable q-pa-md", "I am groot!<br>(Hover me!)", [
            tooltip("I am groot!")
       ])
julia> 
])
```

----------
# Arguments
----------

1. Behaviour
      * `transitionshow::String` - Support for inbuilt [transitions](https://v1.quasar.dev/options/transitions) ex. `fade` `slide-down`
      * `transitionhide::String` - Support for inbuilt [transitions](https://v1.quasar.dev/options/transitions) ex. `fade` `slide-down`
      * `scrolltarget::String` - CSS selector or DOM element to be used as a custom scroll container instead of the auto detected one ex. `scrolltarget=".scroll-target-class"` `scrolltarget="#scroll-target-id"` `scrolltarget="body"`
      * `target::Union{String, Bool}` - Configure a target element to trigger Tooltip toggle; 'true' means it enables the parent DOM element, 'false' means it disables attaching events to any DOM elements; By using a String (CSS selector) it attaches the events to the specified DOM element (if it exists) ex. `target=".my-parent"` `target!=false`
      * `noparentevent::Bool` - Skips attaching events to the target DOM element (that trigger the element to get shown)
      * `delay::Int` - Configure Tooltip to appear with delay. default value. `0` ex. `delay!="500"`
      * `hidedelay::Int` - Configure Tooltip to disappear with delay. default value. `0` ex. `hidedelay!="600"`
2. Content
      * `maxheight::String` - The maximum height of the Tooltip; Size in CSS units, including unit name ex. `16px` `2rem`
      * `maxwidth::String` - The maximum width of the Tooltip; Size in CSS units, including unit name ex. `16px` `2rem`
3. Position
      * `anchor::String` - Two values setting the starting position or anchor point of the Tooltip relative to its target ex. `top left` `top middle` `top right` `top start` `top end` `center left` `center middle` `center right` `center start` `center end` `bottom left` `bottom middle` `bottom right` `bottom start` `bottom end`
      * `self::String` - Two values setting the Tooltip's own position relative to its target ex. `top left` `top middle` `top right` `top start` `top end` `center left` `center middle` `center right` `center start` `center end` `bottom left` `bottom middle` `bottom right` `bottom start` `bottom end`
      * `offset::Vector` - An array of two numbers to offset the Tooltip horizontally and vertically in pixels. default value. `[14,14]` ex. `[5, 10]`
4. Style
      * `contentclass::Union{Vector, String, Dict}` - Class definitions to be attributed to the content eg. `my-special-class` `contentclass!="{ 'my-special-class': <condition> }"`
      * `contentstyle::Union{Vector, String, Dict}` - Style definitions to be attributed to the content eg. `background-color: #ff0000` `contentstyle!="{ color: '#ff0000' }"`
"""
function tooltip(fieldname::Symbol, args...; kwargs...)
  q__tooltip(args...; kw([:fieldname => fieldname, kwargs...])...)
end

end
