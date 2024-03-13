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
julia> @vars EditorModel begin
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
]
1. Behaviour
      * `fullscreen::Bool` - Fullscreen mode. Example: `fullscreen = :isFullscreen`
      * `noroutefullscreenexit::Bool` - Changing route app won't exit fullscreen
      * `paragraphtag::String` - Paragraph tag to be used Example. `div`, `p`
2. Content
      * `placeholder::String` - Text to display as placeholder ex. `Type your story here...`
3. Model
      * `value::String` [required!] - Reactive Model of the component
4. State
      * `readonly::Bool` - Put component to readonly mode
      * `disable::Bool` - Disable component
5. Style
       * `square::Bool` - Removes border-radius so borders are squared
       * `minheight::String` - Minimum height of the component default. `10rem` ex. `15rem` `50vh`
       * `flat::Bool` - Applies a 'flat' design (no borders)
       * `dark::Bool` - Notify the component that the background is a dark color
       * `maxheight::String` - CSS unit for maximum height of the input area ex. `100px` `90vh`
       * `height::String` - CSS value to set the height of the editable area ex. `100px` `90vh`
       * `toolbaroutline::Bool` - Toolbar buttons are rendered "outlined"
       * `toolbarpush::Bool` - Toolbar buttons are rendered as a "push-button" type
       * `toolbarrounded::Bool` - Toolbar buttons are rendered "rounded"
       * `contentstyle::Dict` - Object with CSS properties and values for styling the container of `editor` ex. `contentstyle!="{ backgroundColor: '#C0C0C0' }"`
       * `contentclass::Union{Dict, Vector, String}` - CSS classes for the input area ex. `my-special-class` `contentclass!="{ 'my-special-class': <condition> }"`
"""
function editor(fieldname::Symbol, args...; kwargs...)
  q__editor(args...; kw([:fieldname => fieldname, kwargs...], Dict("fullscreen" => "v-model:fullscreen"))...)
end

end
