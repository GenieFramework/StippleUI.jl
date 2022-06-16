module TabGroups

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export tabgroup

register_normal_element("q__tabs", context = @__MODULE__)

"""
      tabgroup(fieldname::Union{Symbol,Nothing} = nothing, args...; kwargs...)

The `menu` component is a convenient way to show menus. Goes very well with `list` as dropdown content, but it's by no means limited to it.
----------
# Examples
----------
### Model

```julia-repl
julia> @reactive mutable struct TabModel <: ReactiveModel
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
  q__tabs(args...; attributes([:fieldname => fieldname, kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
end

end