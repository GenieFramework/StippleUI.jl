module Button

using Revise

import Genie
import Genie.Renderer.Html: HTMLString, normal_element, template_, div

using Stipple, StippleQuasar.API

export button, buttongroup

Genie.Renderer.Html.register_normal_element("q__btn", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__btn__group", context = @__MODULE__)

function button(label::String = "",
                args...;
                iconright::Union{String,Nothing} = nothing,
                textcolor::Union{String,Nothing} = nothing,
                stacked::Bool = false,
                nocaps::Bool = false,
                loading::Union{Symbol,Bool} = false,
                darkpercentage::Bool = false,
                kwargs...)

  k = (:label, )
  v = Any[label]

  k = API.attr_iconright(textcolor, k, v)

  k = API.attr_textcolor(textcolor, k, v)

  if stacked
    k = (k..., :stack)
    push!(v, "")
  end

  if nocaps
    k = (k..., Symbol("no-caps"))
    push!(v, "")
  end

  if darkpercentage
    k = (k..., Symbol("dark-percentage"))
    push!(v, "")
  end

  k = API.attr_loading(loading, k, v)


  template_() do
    q__btn(args...; kwargs..., NamedTuple{k}(v)...)
  end
end


function buttongroup(args...; kwargs...)
  template_() do
    q__btn__group(args...; kwargs...)
  end
end

end