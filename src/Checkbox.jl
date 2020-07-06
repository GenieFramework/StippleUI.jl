module Checkbox

using Revise

import Genie, Stipple
import Genie.Renderer.Html: HTMLString, normal_element, template_

using Stipple

export checkbox

Genie.Renderer.Html.register_normal_element("q__checkbox", context = @__MODULE__)

function checkbox(fieldname::Symbol, args...; kwargs...)
  template_() do
    q__checkbox(v__model=fieldname, args...; kwargs...)
  end
end

end