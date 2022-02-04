module Editors

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, select, template, register_normal_element

export editor

register_normal_element("q__editor", context = @__MODULE__)

"""
  editor(fieldname, args...; kwargs...)

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
function editor(fieldname::Symbol, args...; kwargs...)
  q__editor(args...; attributes([:fieldname => fieldname, kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
end

end
