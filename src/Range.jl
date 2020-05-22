module Range

using Revise

import Genie, Stipple
import Genie.Renderer.Html: HTMLString, normal_element

using Stipple

Genie.Renderer.Html.register_normal_element("q__range", context = @__MODULE__)


Base.@kwdef mutable struct RangeData{T}
  range::UnitRange{T}
end

function Base.range(fieldname::Symbol, range::StepRange;
  labelalways::Bool = false,
  labelvalueleft::Union{String,Nothing} = nothing,
  labelvalueright::Union{String,Nothing} = nothing,
  markers::Bool = false,
  snap::Bool = false,
  dragrange::Bool = false,
  dragonlyrange::Bool = false,
  dark::Bool = false,
  readonly::Bool = false,
  args...)

  k = (Symbol(":min"), Symbol(":max"), Symbol(":step"))
  v = Any[range.start, range.stop, range.step]

  if labelalways
    k = (k..., Symbol("label-always"))
    push!(v, true)
  end

  if labelvalueleft !== nothing
    k = (k..., Symbol(":left-label-value"))
    push!(v, labelvalueleft)
  end

  if labelvalueright !== nothing
    k = (k..., Symbol(":right-label-value"))
    push!(v, labelvalueright)
  end

  if markers
    k = (k..., :markers)
    push!(v, true)
  end

  if snap
    k = (k..., :snap)
    push!(v, true)
  end

  if dragrange
    k = (k..., Symbol("drag-range"))
    push!(v, true)
  end

  if dragonlyrange
    k = (k..., Symbol("drag-only-range"))
    push!(v, true)
  end

  if dark
    k = (k..., :dark)
    push!(v, true)
  end

  if readonly
    k = (k..., :readonly)
    push!(v, true)
  end

  q__range(v__model=fieldname; args..., NamedTuple{k}(v)...)
end

function Stipple.render(rd::RangeData{T}, fieldname::Union{Symbol,Nothing} = nothing) where {T,R}
  Dict(:min => rd.range.start, :max => rd.range.stop)
end

function Base.parse(::Type{RangeData{T}}, d::Dict{X,Y}) where {T,X,Y}
  RangeData(d["min"]:d["max"])
end

end