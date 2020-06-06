module Badge

using Revise

import Genie, Stipple
import Genie.Renderer.Html: HTMLString, normal_element

using Stipple

export badge

Genie.Renderer.Html.register_normal_element("q__badge", context = @__MODULE__)

function badge(args...; kwargs...)
  q__badge(args...; kwargs...)
end

end