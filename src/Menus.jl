module Menus

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export menu

function __init__()
  Genie.Renderer.Html.register_normal_element("q__menu", context = Genie.Renderer.Html)
end

function menu(
              fieldname::Union{Symbol,Nothing} = nothing,
              args...;
              content::Union{String,Vector} = "",
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              kwargs...)

  wrap() do
    Genie.Renderer.Html.q__menu(args...; attributes([:fieldname => fieldname, kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...) do
      join(content)
    end
  end
end

function menu(content::Function,
              fieldname::Union{Symbol,Nothing} = nothing,
              args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              kwargs...)
  menu(label, fieldname, args...; wrap = wrap, content = content(), kwargs...)
end

end
