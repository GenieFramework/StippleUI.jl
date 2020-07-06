module List

using Revise

import Genie, Stipple
import Genie.Renderer.Html: HTMLString, normal_element, template_

using Stipple, StippleQuasar.API

export list, item, item_section, item_label

Genie.Renderer.Html.register_normal_element("q__list", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__item", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__item__section", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__item__label", context = @__MODULE__)

function list(args...; kwargs...)
  template_() do
    q__list(args...; kwargs...)
  end
end

function item(args...;
              vripple::Bool = true,
              insetlevel::Union{Int,Nothing} = nothing,
              manualfocus::Bool = false,
              clickable::Bool = false,
              kwargs...)

  k = (Symbol("v-ripple"), )
  v = Any[vripple]

  if insetlevel !== nothing
    k = (k..., Symbol("inset-level"))
    push!(v, insetlevel)
  end

  if manualfocus
    k = (k..., Symbol("manual-focus"))
    push!(v, true)
  end

  q__item(args...; kwargs..., NamedTuple{k}(v)...)
end

function item_section(args...;
                      avatar::Bool = false,
                      nowrap::Bool = false,
                      kwargs...)

  k = (:avatar, )
  v = Any[avatar]

  k = API.attr_nowrap(nowrap, k, v)

  q__item__section(args...; kwargs..., NamedTuple{k}(v)...)
end

function item_label(args...; kwargs...)
  q__item__label(args...; kwargs...)
end

end