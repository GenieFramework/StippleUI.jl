module Chips

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export chip

register_normal_element("q__chip", context = @__MODULE__)

function chip(label::String = "",
              fieldname::Union{Symbol,Nothing} = nothing,
              args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              kwargs...)

  wrap() do
    q__chip(args...; attributes([:label => label, :fieldname => fieldname, kwargs...],
                                          StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

end
