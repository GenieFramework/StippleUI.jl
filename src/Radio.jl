module Radio

import Genie, Stipple
import Genie.Renderer.Html: HTMLString, normal_element, template

using Stipple

export radio

Genie.Renderer.Html.register_normal_element("q__radio", context = @__MODULE__)

function radio( label::String = "",
                fieldname::Union{Symbol,Nothing} = nothing,
                args...;
                keepcolor::Bool = false,
                leftlabel::Bool = false,
                kwargs...)

  k = (:label, )
  v = Any[label]

  if fieldname !== nothing
    k = (k..., Symbol("v-model"))
    push!(v, fieldname)
  end

  if keepcolor
    k = (k..., Symbol("keep-color"))
    push!(v, true)
  end

  if leftlabel
    k = (k..., Symbol("left-label"))
    push!(v, true)
  end

  template() do
    q__radio(args...; kwargs..., NamedTuple{k}(v)...)
  end
end

end
