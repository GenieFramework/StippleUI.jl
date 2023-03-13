module Tabs

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export tab, tabgroup

register_normal_element("q__tab", context = @__MODULE__)
register_normal_element("q__tabs", context = @__MODULE__)

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
  q__tab(args...; kw(kwargs)...)
end

"""
      tabgroup(fieldname::Union{Symbol,Nothing} = nothing, args...; kwargs...)

The `menu` component is a convenient way to show menus. Goes very well with `list` as dropdown content, but it's by no means limited to it.
----------
# Examples
----------
### Model

```julia-repl
julia> @vars TabModel begin
          tab_m::R{String} = "tab"
       end
```

### View

```julia-repl
julia> tabgroup(:tab_m, inlinelabel=true, class="bg-primary text-white shadow-2", [
          tab(name="photos", icon="photos", label="Photos"),
          tab(name="videos", icon="slow_motion_video", label="Videos"),
          tab(name="movies", icon="movie", label="Movies")
       ])
```

-----------
# Arguments
-----------

1. Behaviour
      * `target::Union{Bool, String}` - Breakpoint (in pixels) of tabs container width at which the tabs automatically turn to a justify alignment. Default. `600` | Example. `breakpoint! ="500"`
2. Content
      * `vertical::Bool` - Use vertical design (tabs one on top of each other rather than one next to the other horizontally)
      * `outsidearrows::Bool` - Reserve space for arrows to place them on each side of the tabs (the arrows fade when inactive)
      * `mobilearrows::Bool` - Force display of arrows (if needed) on mobile
      * `align::String` - Horizontal alignment the tabs within the tabs container. Default: `center` | Accepted Values: `left`, `center`, `right` `justify` | Example. `right`
      * `breakpoint::Union{Int, String}` - Breakpoint (in pixels) of tabs container width at which the tabs automatically turn to a justify alignment. Default: `600` | Example. `breakpoint! = "500"`
      * `lefticon::String` - The name of an icon to replace the default arrow used to scroll through the tabs to the left, when the tabs extend past the width of the tabs container. Example: `arrow_left`
      * `righticon::String` - The name of an icon to replace the default arrow used to scroll through the tabs to the right, when the tabs extend past the width of the tabs container. Example: `arrow_right`
      * `stretch::Bool` - When used on flexbox parent, tabs will stretch to parent's height
      * `shrink::Bool` - By default, `tabs` is set to grow to the available space; However, you can reverse that with this prop; Useful (and required) when placing the component in a `toolbar`
      * `switchindicator::Bool` - Switches the indicator position (on left of tab for vertical mode or above the tab for default horizontal mode)
      * `narrowindicator::Bool` - Allows the indicator to be the same width as the tab's content (text or icon), instead of the whole width of the tab
      * `inlinelabel::Bool` - Allows the text to be inline with the icon, should one be used
      * `nocaps::Bool` - Turns off capitalizing all letters within the tab (which is the default)
3. Style
      * `activeclass::String` - The class to be set on the active tab
      * `activecolor::String` - The color to be attributed to the text of the active tab. Examples. `teal-10` `primary`
      * `activecolorbg::String` - The color to be attributed to the background of the active tab. Examples. `teal-10` `primary`
      * `indicatorcolor::String` - The color to be attributed to the indicator (the underline) of the active tab. Examples. `teal-10` `primary`
      * `contentclass::String` - Class definitions to be attributed to the content wrapper
      * `dense::Bool` - Dense mode; occupies less space
"""
function tabgroup(fieldname::Union{Symbol,Nothing} = nothing,
                  args...;
                  kwargs...)
  q__tabs(args...; kw([:fieldname => fieldname, kwargs...])...)
end

end