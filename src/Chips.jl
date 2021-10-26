module Chips

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export chip

function __init__()
  Genie.Renderer.Html.register_normal_element("q__chip", context = Genie.Renderer.Html)
end

function chip(label::String = "",
              fieldname::Union{Symbol,Nothing} = nothing,
              args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              kwargs...)

  wrap() do
    Genie.Renderer.Html.q__chip(args...; attributes([:label => label, :fieldname => fieldname, kwargs...],
                                          StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

end
