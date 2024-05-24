module TimePickers

using Genie, Stipple, StippleUI, StippleUI.API
using Dates

import Genie.Renderer.Html: HTMLString, normal_element, template, register_normal_element

export timepicker

register_normal_element("q__time", context= @__MODULE__)

"""
    tabpanelgroup(args...; kwargs...)

The `timepicker` component provides a method to input time.

----------
### Examples
----------

### Model

```julia-repl
julia> @vars TabPanelModel begin
         time::R{Time} = Dates.Time(t -> Dates.minute(t) == 20, 23)
         timewithseconds::R{Time} = Dates.Time(t -> Dates.second(t) == 12, 20, 23)
       end
```

### View
```julia-repl
julia> Html.div(class="q-gutter-md", [
         timepicker(:time, mask="HH:mm"),
         timepicker(:timewithseconds, mask="HH:mm:ss")
       ])
```

----------
### Arguments
----------

1. Behaviour
      * `name:String` - Used to specify the name of the control; Useful if dealing with forms submitted directly to a URL
      * `landscape::Bool` - Display the component in landscape mode
      * `format24h::Bool` - Forces 24 hour time display instead of AM/PM system
      * `options::String` - Optionally configure what time is the user allowed to set; Overridden by 'hour-options', 'minute-options' and 'second-options' if those are set; For best performance, reference it from your scope and do not define it inline. ex. `options!="(hr, min, sec) => hr <= 6"`
      * `optionshour::Array` - Optionally configure what hours is the user allowed to set; Overrides 'options' prop if that is also set. ex. `optionshour! ="[3,6,9]"`
      * `optionsminute::Array` - Optionally configure what minutes is the user allowed to set; Overrides 'options' prop if that is also set ex. `optionsminute! ="[3,6,9]"`
      * `optionssecond::Array` - Optionally configure what seconds is the user allowed to set; Overrides 'options' prop if that is also set ex. `optionssecond! ="[3,6,9]"`
      * `withseconds::Bool` - Allow the time to be set with seconds
2. Content
      * `nowbtn::Bool` - Display a button that selects the current time
3. Model
      * `mask::String` - Mask (formatting string) used for parsing and formatting value ex.  `HH:mm:ss``
      * `withseconds::Bool` - Allow the time to be set with seconds
4. State
      * `readonly::Bool` - Put component in readonly mode
      * `disable::Bool` - Put component in disabled mode
5. Style
      * `color::String` - Color of the component from the color palette
      * `textcolor::String` - Overrides text color (if needed); Color name from the Quasar Color Palette
      * `dark::Bool` - Notify the component that the background is a dark color
      * `square::Bool` - Removes border-radius so borders are squared
      * `flat::Bool` - Applies a 'flat' design (no default shadow)
      * `bordered::Bool` - Applies a default border to the component
"""
function timepicker(fieldname::Union{Symbol,Nothing} = nothing,
                    args...;
                    kwargs...)
    q__time(args...; kw([:fieldname => fieldname, kwargs...])...)
end

end