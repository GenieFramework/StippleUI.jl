module Tabs

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export tab

register_normal_element("q__tab", context = @__MODULE__)

"""
      tab(args...; kwargs...)

`tabs` are a way of displaying more information using less window real estate.

----------
# Examples
----------

### View

```julia-repl
julia> tab(name="photos", icon="photos", label="Photos")
```

-----------
# Arguments
-----------

1. Content
      * `icon::String` - Icon name following Quasar convention; Make sure you have the icon library installed unless you are using 'img:' prefix; If 'none' (String) is used as value then no icon is rendered (but screen real estate will still be used for it). Examples. `"map"` `"ion-add"` `"img:https://cdn.quasar.dev/logo/svg/quasar-logo.svg"` `"img:path/to/some_image.png"`
      * `label::Union{Int,String}` - A number or string to label the tab. Example. `"Home"`
      * `alert::Union{Bool,String}` - Adds an alert symbol to the tab, notifying the user there are some updates; If its value is not a Boolean, then you can specify a color. Example. `"alert"`
      * `nocaps::Bool` - Turns off capitalizing all letters within the tab (which is the default)
2. General
      * `name::Union{Int,String}` - Panel name. Examples. `"home"` `name! ="1"`
      * `tabindex::Union{Int,String}` - Tabindex HTML attribute value. Examples. `0` `100`
3. State
      * `disable::Bool` - Put component in disabled mode
4. Style
      * `ripple::Union{Bool,Dict}` - Configure material ripple (disable it by setting it to 'false' or supply a config object). Examples. `false` `\"""{"early" => true, "center" => true, "color" => "teal", "keyCodes" => []}\"""`
      * `contentclass::String` - Class definitions to be attributed to the content wrapper. `"my-special-class"`
"""
function tab(args...;
              kwargs...)
  q__tab(args...; attributes([kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
end

end