module BigNumber

using Revise

import Genie, Stipple
import Genie.Renderer.Html: HTMLString, normal_element, template_

using Stipple

export bignumber

Genie.Renderer.Html.register_normal_element("st__big__number", context = @__MODULE__)

function bignumber(;
                    label::String = "",
                    number::Union{Number,Symbol,String} = 0,
                    icon::Union{String,Symbol} = "",
                    color::Union{String,Symbol} = "",
                    arrow::Union{String,Symbol} = "",
                    kwargs...)

  k = (:title, Symbol(":number"), :icon, :color, :arrow)
  v = Any[label, number, icon, color, arrow]

  template_() do
    st__big__number(; kwargs..., NamedTuple{k}(v)...)
  end
end

end