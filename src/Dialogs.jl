module Dialogs

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export dialog

register_normal_element("q__dialog", context = @__MODULE__)

"""
    dailog()

The `dialog`` component is a great way to offer the user the ability to choose a specific action or list of actions. They also can provide the user with important information, or require them to make a decision (or multiple decisions).

> TIP: Dialogs can also be used as a globally available method for more basic use cases, like the native JS `alert()`, `prompt()`, etc.

----------
# Examples
----------

### Model

```julia-repl
julia> @vars DialogModel begin
         show_dialog::R{Bool} = false
       end
```

### View
```julia-repl
julia> Html.div(class="q-pa-md q-gutter-sm", [
        btn("Alert", color="primary", @click("show_dialog = true")),
        StippleUI.dialog(:show_dialog, [
          card([
            card_section(Html.div(class="text-h6", "Alert")),
            card_section(class="q-pt-none", "Lorem ipsum dolor sit amet consectetur adipisicing elit. 
            Rerum repellendus sit voluptate voluptas eveniet porro. Rerum blanditiis perferendis totam, 
            ea at omnis vel numquam exercitationem aut, natus minima, porro labore.")
          ])
        ])
      ])
```

----------
# Arguments
----------
1. Behaviour
      * `persistent::Bool` - User cannot dismiss Dialog if clicking outside of it or hitting ESC key; Also, an app route change won't dismiss it
      * `noesc::Bool` - User cannot dismiss Dialog by hitting ESC key; No need to set it if 'persistent' property is also set
      * `nobackdrop::Bool` - User cannot dismiss Dialog by clicking outside of it; No need to set it if 'persistent' property is also set
      * `autoclose::Bool` - Any click/tap inside of the dialog will close it
      * `transitionshow::String` - One of the [embedded transitions](https://v1.quasar.dev/options/transitions) eg. `"fade"`, `"slide-down"`
      * `transitionhide::String` - One of the [embedded transitions](https://v1.quasar.dev/options/transitions) eg. `"fade"`, `"slide-down"`
      * `norefocus::Bool` - (Accessibility) When Dialog gets hidden, do not refocus on the DOM element that previously had focus
      * `nofocus::Bool` - (Accessibility) When Dialog gets shown, do not switch focus on it
2. Content
      * `seamless::Bool` - Put Dialog into seamless mode; Does not use a backdrop so user is able to interact with the rest of the page too
      * `maximized::Bool` - Put Dialog into maximized mode
      * `fullwidth::Bool` - Dialog will try to render with same width as the window
      * `fullheight::Bool` - Dialog will try to render with same height as the window
      * `position::String` - Stick dialog to one of the sides ("top", "right", "bottom" or "left")
3. Style
      * `contentclass::Union{Array, String}` - Class definitions to be attributed to the content eg. `"my-special-class"` `:content-class="{ 'my-special-class': <condition> }"`
      * `contentstyle::Union{Array, String}` - Style definitions to be attributed to the content eg. `"background-color: #ff0000"` `:content-style="{ color: '#ff0000' }"`
      * `square::Bool` - Forces content to have squared borders
"""
function dialog(fieldname::Symbol, args...; kwargs...)
  q__dialog(args...; kw([:fieldname => fieldname, kwargs...])...)
end

# for compatibility reason with earlier versions
function dialog(args...; kwargs...)
  q__dialog(args...; kw(kwargs)...)
end

end
