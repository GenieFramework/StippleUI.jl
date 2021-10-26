module Editors

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, select, template

export editor

function __init__()
  Genie.Renderer.Html.register_normal_element("q__editor", context = Genie.Renderer.Html)
end

"""
  editor(fieldname, args...; wrap, kwargs...)

Creates a Quasar editor view editing the content stored in the fieldname property
of the model.

Some optional arguments are:
    definitions : A dict or list of toolbar command descriptions
    toolbar: A dict or list describing the arrangement of the toolbar elements
    autocorrect: "on/off", whever to activate autocorrect
    autocapitalize: "on/off"
    autocomplete: "on/off
    spellcheck: "true/false"
"""
function editor(fieldname::Symbol,
                args...;
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                kwargs...)
  wrap() do
    Genie.Renderer.Html.q__editor(args...; attributes([:fieldname => fieldname, kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

end
