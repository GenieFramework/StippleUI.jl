module Timelines

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export timeline, timelineentry

register_normal_element("q__timeline", context = @__MODULE__)
register_normal_element("q__timeline__entry", context = @__MODULE__)

"""
      timeline(args...; kwargs...)

The `timeline` component displays a list of events in chronological order. It is typically a graphic design showing a long bar labelled with dates alongside itself and usually events. Timelines can use any time scale, depending on the subject and data.      

----------
# Examples
----------

### View

```julia-repl
julia> 
```

-----------
# Arguments
-----------

1. Behavior
      * `side::String` - Side to place the timeline entries in dense and comfortable layout; For loose layout it gets overridden by `timelineentry` side prop. (default: `"right"`) | ex. `"left"` | `"right"`
      * `layout::String` - Layout of the timeline. Dense keeps content and labels on one side. Comfortable keeps content on one side and labels on the opposite side. Loose puts content on both sides. (default: `"dense"`) | ex. `"comfortable"` | `"loose"` | `"dense"`
2. Style
      * `color::String` - Color name for component from the Quasar Color Palette. ex. `"primary"` | `"teal-10"`
      * `dark::Bool` - Notify the component that the background is a dark color
"""
function timeline(args...; kwargs...)
  q__timeline(args...; kw(kwargs)...)
end

"""
      timelineentry(args...; kwargs...)

----------
# Examples
----------

### View

```julia-repl
julia> 
```

-----------
# Arguments
-----------

1. Behavior
      * `side::String` -  Side to place the timeline entry; Works only if `timeline` layout is loose. (default: `"right"`) | ex. `"left"` | `"right"`
2. Content
      * `tag::String` - Tag to use, if of type 'heading' only. (default: `"h3"`) | ex. `"h1"` | `"h2"` | `"h3"` | `"h4"` | `"h5"` | `"h6"`
      * `heading::Bool` - Defines a heading timeline item
      * `icon::String` - Icon name following Quasar convention; Make sure you have the icon library installed unless you are using 'img:' prefix; If 'none' (String) is used as value then no icon is rendered (but screen real estate will still be used for it). (ex. `"map"` | `"ion-add"`)
      * `avatar::String` - URL to the avatar image; Icon takes precedence if used, so it replaces avatar.
      * `title::String` - Title of timeline entry; Is overridden if using 'title' slot
      * `subtitle::String` - Subtitle of timeline entry; Is overridden if using 'subtitle' slot
      * `body::String` - Body content of timeline entry; Use this prop or the default slot
3. Style
      * `color::String` - Color name for component from the Quasar Color Palette
"""
function timelineentry(args...; kwargs...)
  q__timeline__entry(args...; kw(kwargs)...)
end

end
