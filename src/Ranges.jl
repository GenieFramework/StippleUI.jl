module Ranges

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template

using Stipple

export range, RangeData, slider

function __init__()
  Genie.Renderer.Html.register_normal_element("q__range", context = Genie.Renderer.Html)
  Genie.Renderer.Html.register_normal_element("q__slider", context = Genie.Renderer.Html)
end

Base.@kwdef mutable struct RangeData{T}
  range::UnitRange{T}
end

function Base.range(
                range::AbstractRange{T} where T <: Real,
                fieldname::Union{Symbol,Nothing} = nothing,
                args...;
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                lazy = false,
                kwargs...)

  wrap() do
    Genie.Renderer.Html.q__range( "", lazy ? @on(:change," val => { $fieldname } ") : "" , args...;
              attributes(
                        [ Symbol(":min") => first(range),
                          Symbol(":max") => last(range),
                          Symbol(":step") => step(range),
                          ( lazy ? () : (:fieldname => fieldname,) )...,
                          kwargs...
                        ], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

function slider(range::AbstractRange{T} where T <: Real,
                fieldname::Union{Symbol, Nothing} = nothing,
                args...;
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                lazy = false,
                kwargs...)

  wrap() do
    Genie.Renderer.Html.q__slider("", lazy ? @on(:change," val => { $fieldname } ") : "", args...;
    attributes(
      [Symbol(":min") => first(range), Symbol(":max") => last(range), Symbol(":step") => step(range),
      ( lazy ? () : (:fieldname => fieldname,) )..., kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

function Stipple.render(rd::RangeData{T}, fieldname::Union{Symbol,Nothing} = nothing) where {T,R}
  Dict(:min => rd.range.start, :max => rd.range.stop)
end

function Base.parse(::Type{RangeData{T}}, d::Dict{X,Y}) where {T,X,Y}
  RangeData(d["min"]:d["max"])
end

end
