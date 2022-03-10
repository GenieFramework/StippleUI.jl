module Editors

using Stipple
using StippleUI

@reactive mutable struct EditorModel <: ReactiveModel
  s_editor::R{String} = "What you see is <b>what</b> you get."
end

function ui(editor_model)
  page(
    editor_model,
    title = "Editor Components",
    class = "container",
    [
      editor(:s_editor, minheight="5rem"),

      # autocorrect and spelling check

      StippleUI.form( autocorrect="off", autocapitalize="off", autocomplete="off", spellcheck="false", [
        editor(:s_editor)
      ])
    ]
  )
end

function factory()
  editor_model = EditorModel |> init
  editor_model
end

end