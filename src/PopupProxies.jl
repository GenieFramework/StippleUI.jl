module PopupProxies

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template, register_normal_element

using Stipple

export popup_proxy, PopupProxy, popupproxy, popup, Popup

register_normal_element("q__popup__proxy", context = @__MODULE__)

"""
      popup_proxy(fieldname::Union{Symbol,Nothing} = nothing, args...; content::Union{String,Vector,Function} = "", kwargs...)

`popupproxy` should be used when you need either a `menu` (on bigger screens) or a `dialog` (on smaller screens) to be displayed. It acts as a proxy which picks either of the two components to use. `popupproxy` also handles context-menus.
      
----------
### Examples
----------

### View

```julia-repl
julia> btn("Handles click", push=true, color="primary", [
          popupproxy([
            banner("You have lost connection to the internet. This app is offline.", [
              template("", "v-slot:avatar", [
                icon("signal_wifi_off", color="Primary")
              ])
            ])
          ])
       ])
```

-----------
### Arguments
-----------

1. Behaviour
      * `target::Union{Bool, String}` - Configure a target element to trigger component toggle; 'true' means it enables the parent DOM element, 'false' means it disables attaching events to any DOM elements; By using a String (CSS selector) or a DOM element it attaches the events to the specified DOM element (if it exists) ex. `true` ex. `target!=false` `target!=".my-parent"`
      * `noparentevent::Bool` - Skips attaching events to the target DOM element (that trigger the element to get shown)
      * `contextmenu::Bool` - Allows the component to behave like a context menu, which opens with a right mouse click (or long tap on mobile)
      * `breakpoint::Union{Int, String}` - Breakpoint (in pixels) of window width/height (whichever is smaller) from where a Menu will get to be used instead of a Dialog ex. `992` `breakpoint!="1234"`
"""
function popup_proxy(
                      fieldname::Union{Symbol,Nothing} = nothing,
                      args...;
                      content::Union{String,Vector,Function} = "",
                      kwargs...)

  q__popup__proxy([isa(content, Function) ? content() : join(content)],
                    args...;
                    kw([:fieldname => fieldname, kwargs...])...
  )
end

popup_proxy(content::Union{Vector,Function},
            fieldname::Union{Symbol,Nothing} = nothing,
            args...;
            kwargs...) = popup_proxy(fieldname, args...; content, kwargs...)

const popupproxy = popup_proxy
const popup = popup_proxy

mutable struct PopupProxy
  fieldname
  args
  content
  kwargs

  PopupProxy( fieldname::Union{Symbol,Nothing} = nothing,
              args...;
              content::Union{String,Vector,Function} = "",
              kwargs...) = new(fieldname, args, content, kwargs)
end
const Popup = PopupProxy

Base.string(pp::PopupProxy) = popup_proxy(pp.fieldname, pp.args...; pp.content, pp.kwargs...)

end
