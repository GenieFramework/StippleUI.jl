module Range

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template

using Stipple

export range, RangeData, slider

Genie.Renderer.Html.register_normal_element("q__range", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__slider", context = @__MODULE__)


Base.@kwdef mutable struct RangeData{T}
  range::UnitRange{T}
end

function range( range::AbstractRange{T} where T <: Real,
                fieldname::Union{Symbol,Nothing},
                args...;
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                kwargs...)

  wrap() do
    q__range(args...; attributes(
      [Symbol(":min") => first(range), Symbol(":max") => last(range), Symbol(":step") => step(range),
      :fieldname => fieldname, kwargs...],
      Dict("fieldname" => "v-model", "dragonlyrange" => "drag-only-range", "dragrange" => "drag-range",
            "labelvalueright" => "right-label-value", "labelvalueleft" => "left-label-value", "labelalways" => "label-always")
    )...)
  end
end

function slider(range::AbstractRange{T} where T <: Real,
                fieldname::Symbol,
                args...;
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                kwargs...)

  wrap() do
    q__slider(args...; attributes(
      [Symbol(":min") => first(range), Symbol(":max") => last(range), Symbol(":step") => step(range),
      :fieldname => fieldname, kwargs...],
      Dict("fieldname" => "v-model", "labelvalue" => "label-value", "labelalways" => "label-always")
    )...)
  end
end

function Stipple.render(rd::RangeData{T}, fieldname::Union{Symbol,Nothing} = nothing) where {T,R}
  Dict(:min => rd.range.start, :max => rd.range.stop)
end

function Base.parse(::Type{RangeData{T}}, d::Dict{X,Y}) where {T,X,Y}
  RangeData(d["min"]:d["max"])
end

end
