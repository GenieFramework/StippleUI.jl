module ScrollAreas

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template, register_normal_element

export scrollarea

register_normal_element("q__scroll__area", context = @__MODULE__)

"""
      scrollarea(args...; kwargs...)
    
The `scrollarea` component offers a neat way of customizing the scrollbars by encapsulating your content. Think of it as a DOM element which has `overflow: auto`, but with your own custom styled scrollbar instead of browser’s default one and a few nice features on top.

----------
### Examples
----------

### View

```julia-repl
julia> StippleUI.scrollarea(style="height: 200px; max-width: 300px;", [
          Html.div("Stipple is a reactive UI library for building interactive 
          data applications in pure Julia. It uses Genie.jl (on the server side)
          and Vue.js (on the client). Stipple uses a high performance MVVM 
          architecture, which automatically synchronizes the state two-way
          (server -> client and client -> server) sending only JSON data over
          the wire. The Stipple package provides the fundamental communication
          layer, extending Genie's HTML API with a reactive component.")
       ])
```

-----------
### Arguments
-----------

1. Behaviour
      * `visible::Bool` - Manually control the visibility of the scrollbar; Overrides default mouse over/leave behavior
      * `delay::Union{Int, String}` - When content changes, the scrollbar appears; this delay defines the amount of time (in milliseconds) before scrollbars disappear again (if component is not hovered) default `1000` ex. `500` `delay!="500`
      * `horizontal::Bool` - Changes the default axis to horizontal instead of vertical (which is default) for getScrollPosition, getScrollPercentage, setScrollPosition, and setScrollPercentage
2. General
      * `tabindex::Union{Int, String}` - Tabindex HTML attribute value `0` `100`
3. Style
      * `dark::Bool` - Notify the component that the background is a dark color
      * `barstyle::Union{Vector, String, Dict}` - Object with CSS properties and values for custom styling the scrollbars (both vertical and horizontal) ex. `barstyle!="{ borderRadius: '5px', background: 'red', opacity: 1 }"`
      * `contentstyle::Union{Vector, String, Dict}` - Object with CSS properties and values for styling the container of `scrollarea`
"""
function scrollarea(args...; kwargs...)
  q__scroll__area(args...; kw(kwargs)...)
end

end
