module Checkboxes

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export checkbox

function __init__()
  Genie.Renderer.Html.register_normal_element("q__checkbox", context = Genie.Renderer.Html)
end

function checkbox(label::String = "",
                  fieldname::Union{Symbol,Nothing} = nothing,
                  args...;
                  wrap::Function = StippleUI.DEFAULT_WRAPPER,
                  kwargs...)

  wrap() do
    Genie.Renderer.Html.q__checkbox(args...; attributes([:label => label, :fieldname => fieldname, kwargs...],
                                              StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

end
