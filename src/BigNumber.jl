module BigNumber

using Revise

import Genie, Stipple
import Genie.Renderer.Html: HTMLString, normal_element, template_

using Stipple

export bignumber

Genie.Renderer.Html.register_normal_element("st__big__number", context = @__MODULE__)

function bignumber( label::String = "",
                    number::Union{Symbol,Number,String} = nothing,
                    args...;
                    icon::Union{String,Nothing} = nothing,
                    color::Union{String,Nothing} = nothing,
                    arrow::Union{String,Nothing} = nothing,
                    kwargs...)

  k = (:title, :icon, :color, :arrow)
  v = Any[label, icon, color, arrow]

  if number !== nothing
    k = (k..., Symbol(":number"))
    push!(v, number)
  end

  if icon !== nothing
    k = (k..., :icon)
    push!(v, icon)
  end

  if color !== nothing
    k = (k..., :color)
    push!(v, color)
  end

  if arrow !== nothing
    k = (k..., :arrow)
    push!(v, arrow)
  end

  template_() do
    st__big__number(args...; kwargs..., NamedTuple{k}(v)...)
  end
end

end