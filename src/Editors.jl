module Editors

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, select, template, register_normal_element

export editor

register_normal_element("q__editor", context = @__MODULE__)

"""
  editor(fieldname, args...; kwargs...)

Component is a WYSIWYG (“what you see is what you get”) editor component that enables the user to write and even paste HTML.

----------
# Examples
----------

### Model

```julia-repl
julia> @reactive mutable struct EditorModel <: ReactiveModel
          s_editor::R{String} = "What you see is <b>what</b> you get."
       end
```

### View
```julia-repl
julia> editor(:s_editor, minheight="5rem")

julia> StippleUI.form( autocorrect="off", autocapitalize="off", autocomplete="off", spellcheck="false", [
          editor(:s_editor)
       ])
```

----------
# Arguments
----------

* `readonly::Bool` - Sets editor in readonly mode.
* `disable::Bool` - Sets editor in disable mode.
* `minheight::String` - CSS unit for minimum height of the input area.
* `maxheight::String` - CSS unit for maximum height of the input area.
* `toolbar::Vector` - Vector of Vectors of Strings with toolbar commands
* `toolbartextcolor::String` - Text color from the [Color Palette](https://quasar.dev/style/color-palette) of toolbar commands.
* `toolbartogglecolor::String` - Color from the [Color Palette](https://quasar.dev/style/color-palette) of toolbar commands when in “active” state
* `toolbarbg::String` - Toolbar background color from the [Color Palette](https://quasar.dev/style/color-palette)
"""
function editor(fieldname::Symbol, args...; kwargs...)
  q__editor(args...; kw([:fieldname => fieldname, kwargs...])...)
end

end
