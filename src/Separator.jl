module Separator

import Genie, Stipple
import Genie.Renderer.Html: HTMLString, normal_element, template

using Stipple

export separator

Genie.Renderer.Html.register_normal_element("q__separator", context = @__MODULE__)

function separator(args...; kwargs...)
  template() do
    q__separator(args...; kwargs...)
  end
end

end
