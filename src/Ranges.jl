module Ranges

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template, register_normal_element

using Stipple

export range, RangeData, slider

register_normal_element("q__range", context = @__MODULE__)
register_normal_element("q__slider", context = @__MODULE__)

Base.@kwdef mutable struct RangeData{T}
  range::UnitRange{T}
end

function Base.range(
                range::AbstractRange{T} where T <: Real,
                fieldname::Union{Symbol,Nothing} = nothing,
                args...;
                lazy = false,
                kwargs...)

  q__range( "", lazy ? @on(:change," val => { $fieldname } ") : "" , args...; kw([
              Symbol(":min") => first(range),
              Symbol(":max") => last(range),
              Symbol(":step") => step(range),
              ( lazy ? () : (:fieldname => fieldname,) )...,
              kwargs...
  ])...)
end

function slider(range::AbstractRange{T} where T <: Real,
                fieldname::Union{Symbol, Nothing} = nothing,
                args...;
                lazy = false,
                kwargs...)

  q__slider("", lazy ? @on(:change," val => { $fieldname } ") : "", args...; kw([
              Symbol(":min") => first(range),
              Symbol(":max") => last(range),
              Symbol(":step") => step(range),
              ( lazy ? () : (:fieldname => fieldname,) )...,
              kwargs...
  ])...)
end

function Stipple.render(rd::RangeData{T}, fieldname::Union{Symbol,Nothing} = nothing) where {T,R}
  Dict(:min => rd.range.start, :max => rd.range.stop)
end

function Base.parse(::Type{RangeData{T}}, d::Dict{X,Y}) where {T,X,Y}
  RangeData(d["min"]:d["max"])
end

end
