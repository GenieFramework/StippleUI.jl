module Chip

using Revise

import Genie, Stipple
import Genie.Renderer.Html: HTMLString, normal_element, template_

using Stipple, StippleUI.API

export chip

Genie.Renderer.Html.register_normal_element("q__chip", context = @__MODULE__)

function chip(label::String = "",
              fieldname::Union{Symbol,Nothing} = nothing,
              args...;
              iconright::Union{String,Nothing} = nothing,
              iconremove::Union{String,Nothing} = nothing,
              textcolor::Union{String,Nothing} = nothing,
              kwargs...)

  k = (:label, )
  v = Any[label]

  if fieldname !== nothing
    k = (k..., Symbol("v-model"))
    push!(v, fieldname)
  end

  if iconremove
    k = (k..., Symbol("icon-remove"))
    push!(v, true)
  end

  k = API.attr_iconright(iconright, k, v)

  k = API.attr_textcolor(textcolor, k, v)

  template_() do
    q__chip(args...; kwargs..., NamedTuple{k}(v)...)
  end
end

end