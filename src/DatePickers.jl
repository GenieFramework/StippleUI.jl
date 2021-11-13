"""
`DatePicker` provides UI elements for picking a date, multiple dates, a range of dates,
  or multiple dates ranges. The `DatePicker` module automatically exports `Dates`.

## Example
```julia

```
"""
module DatePickers

using Genie, Stipple, StippleUI, StippleUI.API
using Stipple, Stipple.Reexport

@reexport using Dates

import Genie.Renderer.Html: HTMLString, normal_element, template, register_normal_element

export datepicker, DateRange, DatePicker

register_normal_element("q__date", context = @__MODULE__)

"""
    DateRange

Represents a date interval, between `start` and `stop`, with a 1 day step.
"""
Base.@kwdef mutable struct DateRange
  start::Date = today()
  stop::Date = today()
end

DateRange(dr::StepRange{Date,Day}) = DateRange(dr.start, dr.stop)

"""
    datepicker()

Renders a date picker (calendar) input element.
If the `fieldname` references a `Vector{Date}`, the `multiple` keyword parameter must be passed as `true`.
If the `fieldname` references a `DateRange`, the `range` keyword parameter must be passed as `true`.
If the `fieldname` references a `Vector{DateRange}`, both the `multiple` and the `range` keyword parameters must be passed as `true`.
"""
function datepicker(
                    fieldname::Union{Symbol,Nothing} = nothing,
                    args...;
                    wrap::Function = StippleUI.DEFAULT_WRAPPER,
                    mask::String = "YYYY-MM-DD",
                    content::Union{String,Vector,Function} = "",
                    kwargs...)

  wrap() do
    q__date([isa(content, Function) ? content() : join(content)],
            args...;
            attributes(
                  [ :fieldname => fieldname,
                    :mask => mask,
                    kwargs...
                  ], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

datepicker( content::Union{Vector,Function},
            fieldname::Union{Symbol,Nothing} = nothing,
            args...;
            wrap::Function = StippleUI.DEFAULT_WRAPPER,
            mask::String = "YYYY-MM-DD",
            kwargs...) = datepicker(fieldname, args...; wrap = wrap, mask = mask, content = content, kwargs...)

mutable struct DatePicker
  fieldname
  args
  wrap
  mask
  content
  kwargs

  DatePicker( fieldname::Union{Symbol,Nothing} = nothing,
              args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              mask::String = "YYYY-MM-DD",
              content::Union{String,Vector,Function} = "",
              kwargs...) = new(fieldname, args, wrap, mask, kwargs)
end

Base.string(dp::DatePicker) = datepicker(dp.fieldname, dp.args...; dp.wrap, dp.mask, dp.content, dp.kwargs...)

# internals

function Base.convert(::Type{Date}, d::String) :: Date
  Date(d)
end

function Stipple.render(dr::DateRange, _::Union{Symbol,Nothing} = nothing)
  Dict(:from => dr.start, :to => dr.stop)
end

function Stipple.render(vdr::Vector{DateRange}, _::Union{Symbol,Nothing} = nothing)
  [ Dict(:from => dr.start, :to => dr.stop) for dr in vdr ]
end

function Base.parse(::Type{DateRange}, d::Dict{String,Any})
  DateRange(d["from"], d["to"])
end

Base.convert(::Type{DateRange}, d::Dict{String,Any}) = parse(DateRange, d)

end
