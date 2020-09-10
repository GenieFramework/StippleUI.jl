module Chip

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export chip

Genie.Renderer.Html.register_normal_element("q__chip", context = @__MODULE__)

function chip(label::String = "",
              fieldname::Union{Symbol,Nothing} = nothing,
              args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              kwargs...)

  wrap() do
    q__chip(args...; attributes([:label => label, :fieldname => fieldname, kwargs...],
                                Dict("fieldname" => "v-model", "iconremove" => "icon-remove",
                                      "iconright" => "icon-right", "textcolor" => "text-color", ))...)
  end
end

end
