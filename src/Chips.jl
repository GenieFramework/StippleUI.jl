module Chips

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export chip

register_normal_element("q__chip", context = @__MODULE__)

"""
      chip(args...; kwargs...)
    
The `chip` component is basically a simple UI block entity, representing for example more advanced underlying data, such as a contact, in a compact way.

Chips can contain entities such as an avatar, text or an icon, optionally having a pointer too. They can also be closed or removed if configured so.

----------
# Examples
----------

### View

```julia-repl
julia> chip("Add to calendar", icon="event")
```

-----------
# Arguments
-----------

1. Content
      * `icon::String` - Icon name following Quasar convention; Make sure you have the icon library installed unless you are using 'img:' prefix; If 'none' (String) is used as value then no icon is rendered (but screen real estate will still be used for it) ex. `"map"` `"ion-add"` `"img:https://cdn.quasar.dev/logo/svg/quasar-logo.svg"` `"img:path/to/some_image.png"`
      * `iconright::String` - Icon name following Quasar convention; Make sure you have the icon library installed unless you are using 'img:' prefix; If 'none' (String) is used as value then no icon is rendered (but screen real estate will still be used for it) ex. `"map"` `"ion-add"` `"img:https://cdn.quasar.dev/logo/svg/quasar-logo.svg"` `"img:path/to/some_image.png"`
      * `iconremove::String` - Icon name following Quasar convention; Make sure you have the icon library installed unless you are using 'img:' prefix; If 'none' (String) is used as value then no icon is rendered (but screen real estate will still be used for it) ex. `"map"` `"ion-add"` `"img:https://cdn.quasar.dev/logo/svg/quasar-logo.svg"` `"img:path/to/some_image.png"`
      * `iconselected::String` - Icon name following Quasar convention; Make sure you have the icon library installed unless you are using 'img:' prefix; If 'none' (String) is used as value then no icon is rendered (but screen real estate will still be used for it) ex. `"map"` `"ion-add"` `"img:https://cdn.quasar.dev/logo/svg/quasar-logo.svg"` `"img:path/to/some_image.png"`
      * `label::Union{String, Int}` - Chip's content as string; overrides default slot if specified ex. `"Joe Doe"` `"Book"`
2. General
      * `tabindex::Union{Int, String}` - Tabindex HTML attribute value ex. `0` `100`
3. Model
      * `value::Bool` - Model of the component determining if `chip` should be rendered or not default. `true`
      * `selected::Bool` - Model for `chip` if it's selected or not NOTE. ".sync" modifier required!
4. State
      * `clickable::Bool` - Is `chip` clickable? If it's the case, then it will add hover effects and emit 'click' events
      * `removable::Bool` - Is `chip` removable? If it's the case, then it will add a close button and emit 'remove' events
      * `disable::Bool` - Put component in disabled mode
5. Style
      * `ripple::Union{Bool, Dict}` - Configure material ripple (disable it by setting it to 'false' or supply a config object) default. `true` ex. `false` `{ early: true, center: true, color: 'teal', keyCodes: [] }`
      * `dense::Bool` - Dense mode; occupies less space
      * `size::String` - `chip` size name or a CSS unit including unit name ex. `"xs"` `"sm"` `"md"` `"lg"` `"xl"` `"1rem"`
      * `dark::Bool` - Notify the component that the background is a dark color
      * `color::String` - Color name for component from the [Color Palette](https://quasar.dev/style/color-palette) eg. `"primary"` `"teal-10"`
      * `square::Bool` - Sets a low value for border-radius instead of the default one, making it close to a square
      * `outline::Bool` - Display using the 'outline' design
"""
function chip(args...; kwargs...)
  q__chip(args...; kw(kwargs)...)
end

end
