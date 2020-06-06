module Select

using Revise

import Genie, Stipple
import Genie.Renderer.Html: HTMLString, normal_element, select

using Stipple

Genie.Renderer.Html.register_normal_element("q__select", context = @__MODULE__)

function Genie.Renderer.Html.select(fieldname::Symbol;
                options::Symbol,
                args...)

  k = (Symbol(":options"),)
  v = Any[options]

  q__select(v__model=fieldname; args..., NamedTuple{k}(v)...)
end

end