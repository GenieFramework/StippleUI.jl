module Icon

using Revise

import Genie
import Genie.Renderer.Html: HTMLString, normal_element, template_

using Stipple

export icon

Genie.Renderer.Html.register_normal_element("q__icon", context = @__MODULE__)

function icon(name::Union{String,Symbol},
              args...;
              kwargs...)

  k = (:name, )
  v = Any[string(name)]

  template_() do
    q__icon(args...; kwargs..., NamedTuple{k}(v)...)
  end
end

end