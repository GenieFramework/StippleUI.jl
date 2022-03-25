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

1. Behaviour
      * `fullscreen::Bool` - Fullscreen mode (Note".sync" modifier required!) Example. `:fullscreen.sync="isFullscreen"`
      * `noroutefullscreenexit::Bool` - Changing route app won't exit fullscreen
      * `paragraphtag::String` - Paragraph tag to be used Example. `div`, `p`
2. Content
      * 
3. Label
      * 
4. Model
      * 
5. State
      * 
6. Style
      * 
7. Toolbar
      *
"""
function editor(fieldname::Symbol, args...; kwargs...)
  q__editor(args...; kw([:fieldname => fieldname, kwargs...])...)
end

end
