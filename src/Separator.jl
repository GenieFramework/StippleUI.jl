module Separator

using Revise

import Genie, Stipple
import Genie.Renderer.Html: HTMLString, normal_element, template_

using Stipple

export separator

Genie.Renderer.Html.register_normal_element("q__separator", context = @__MODULE__)

function separator(args...; kwargs...)
  template_() do
    q__separator(args...; kwargs...)
  end
end

end