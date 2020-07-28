module Badge

using Revise

import Genie, Stipple
import Genie.Renderer.Html: HTMLString, normal_element, template_

using Stipple, StippleUI.API

export badge

Genie.Renderer.Html.register_normal_element("q__badge", context = @__MODULE__)

function badge( label::String = "",
                fieldname::Union{Symbol,Nothing} = nothing,
                args...;
                multiline::Bool = false,
                textcolor::Union{String,Nothing} = nothing,
                kwargs...)

  k = (:label, )
  v = Any[label]

  if fieldname !== nothing
    k = (k..., Symbol("v-model"))
    push!(v, fieldname)
  end

  k = API.attr_textcolor(textcolor, k, v)

  if multiline
    k = (k..., Symbol("multi-line"))
    push!(v, "")
  end

  template_() do
    q__badge(args...; kwargs..., NamedTuple{k}(v)...)
  end
end

end