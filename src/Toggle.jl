module Toggle

import Genie, Stipple
import Genie.Renderer.Html: HTMLString, normal_element, template

using Stipple

export toggle

Genie.Renderer.Html.register_normal_element("q__toggle", context = @__MODULE__)

function toggle(label::String = "",
                fieldname::Union{Symbol,Nothing} = nothing,
                args...;
                indeterminatevalue::Union{Any,Nothing} = nothing,
                indeterminateicon::Union{Any,Nothing} = nothing,
                toggleorder::Union{String,Nothing} = nothing,
                checkedicon::Union{String,Nothing} = nothing,
                uncheckedicon::Union{String,Nothing} = nothing,
                iconcolor::Union{String,Nothing} = nothing,
                truevalue::Union{Any,Nothing} = nothing,
                falsevalue::Union{Any,Nothing} = nothing,
                toggleindeterminate::Bool = false,
                keepcolor::Bool = false,
                leftlabel::Bool = false,
                kwargs...)

  k = (:label, )
  v = Any[label]

  if fieldname !== nothing
    k = (k..., Symbol("v-model"))
    push!(v, fieldname)
  end

  if indeterminatevalue !== nothing
    k = (k..., Symbol("indeterminate-value"))
    push!(v, indeterminatevalue)
  end

  if indeterminateicon !== nothing
    k = (k..., Symbol("indeterminate-icon"))
    push!(v, indeterminateicon)
  end

  if toggleorder !== nothing
    k = (k..., Symbol("toggle-order"))
    push!(v, toggleorder)
  end

  if checkedicon !== nothing
    k = (k..., Symbol("checked-icon"))
    push!(v, checkedicon)
  end

  if uncheckedicon !== nothing
    k = (k..., Symbol("unchecked-icon"))
    push!(v, uncheckedicon)
  end

  if iconcolor !== nothing
    k = (k..., Symbol("icon-color"))
    push!(v, iconcolor)
  end

  if truevalue !== nothing
    k = (k..., Symbol("true-value"))
    push!(v, truevalue)
  end

  if falsevalue !== nothing
    k = (k..., Symbol("false-value"))
    push!(v, falsevalue)
  end

  if toggleindeterminate
    k = (k..., Symbol("toggle-indeterminate"))
    push!(v, true)
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
    q__toggle(args...; kwargs..., NamedTuple{k}(v)...)
  end
end

end
