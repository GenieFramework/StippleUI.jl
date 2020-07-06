module Select

using Revise

import Genie, Stipple
import Genie.Renderer.Html: HTMLString, normal_element, select, template_

using Stipple

Genie.Renderer.Html.register_normal_element("q__select", context = @__MODULE__)

function Genie.Renderer.Html.select(fieldname::Symbol,
                args...;
                options::Symbol,
                kwargs...)

  k = (Symbol(":options"),)
  v = Any[options]

  template_() do
    q__select(v__model=fieldname, args...; kwargs..., NamedTuple{k}(v)...)
  end
end

end