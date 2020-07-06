module Chip

using Revise

import Genie, Stipple
import Genie.Renderer.Html: HTMLString, normal_element, template_

using Stipple, StippleQuasar.API

export chip

Genie.Renderer.Html.register_normal_element("q__chip", context = @__MODULE__)

function chip(label::String = "",
              args...;
              iconright::Union{String,Nothing} = nothing,
              textcolor::Union{String,Nothing} = nothing,
              kwargs...)

  k = (:label, )
  v = Any[label]

  k = API.attr_iconright(textcolor, k, v)

  k = API.attr_textcolor(textcolor, k, v)

  template_() do
    q__chip(args...; kwargs..., NamedTuple{k}(v)...)
  end
end

end