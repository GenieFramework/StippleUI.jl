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

----------
# Examples
----------

### Model

```julia-repl
julia> @vars DatePickers begin
        date::R{Date} = today() + Day(30)
        dates::R{Vector{Date}} = Date[today()+Day(10), today()+Day(20), today()+Day(30)]
        daterange::R{DateRange} = DateRange(today(), (today() + Day(3)))
        dateranges::R{Vector{DateRange}} = [
          DateRange(today(), (today() + Day(3))),
          DateRange(today() + Day(7), (today() + Day(10))),
          DateRange(today() + Day(14), (today() + Day(17))),
        ]
        proxydate::R{Date} = today()
        inputdate::R{Date} = today()
      end
```

### View

```julia-repl
julia> datepicker(:date)
julia> datepicker(:dates, multiple = true)
julia> datepicker(:daterange, range = true)
julia> datepicker(:dateranges, range = true, multiple = true)
```

-----------
# Arguments
-----------

1. Behavior
      * `name::String` - Used to specify the name of the control; Useful if dealing with forms submitted directly to a URL ex. `"car_id"`
      * `landscape::Bool` - Display the component in landscape mode
      * `yearsinmonthview::Bool` - Show the years selector in months view
2. Content
      * `title::String` - When specified, it overrides the default header title; Makes sense when not in 'minimal' mode ex. `"Birthday"`
      * `subtitle::String`  - When specified, it overrides the default header subtitle; Makes sense when not in 'minimal' mode ex. `"John Doe"`
      * `todaybtn::Bool` - Display a button that selects the current day
      * `minimal::Bool` - Don't display the header
3. Selection
      * `navminyearmonth::String` - Lock user from navigating below a specific year+month (in YYYY/MM format); This prop is not used to correct the model; You might want to also use 'default-year-month' prop ex. `"2020/07"`
      * `navmaxyearmonth::String` - Lock user from navigating above a specific year+month (in YYYY/MM format); This prop is not used to correct the model; You might want to also use 'default-year-month' prop ex. `"2020/10"`
      * `nounset::Bool` - Remove ability to unselect a date; It does not apply to selecting a range over already selected dates
      * `multiple::Bool` - Allow multiple selection; Model must be Array
      * `range::Bool` - Allow range selection; Partial compatibility with 'options' prop: selected ranges might also include 'unselectable' days
4. State
      * `readonly::Bool` - Put component in readonly mode
      * `disable::Bool` - Put component in disabled mode
5. Style
      * `color::String` - Color name for component from the Quasar Color Palette ex. `"primary"` `"teal-10"`
      * `textcolor::String` - Overrides text color (if needed); Color name from the Quasar Color Palette ex. `"primary"` `"teal-10"`
      * `dark::Bool` - Notify the component that the background is a dark color
      * `square::Bool` - Removes border-radius so borders are squared
      * `flat::Bool` - Applies a 'flat' design (no default shadow)
      * `bordered::Bool` - Applies a default border to the component
      * `eventcolor::String` - Color name (from the Quasar Color Palette); If using a function, it receives the date as a String and must return a String (color for the received date); If using a function then for best performance, reference it from your scope and do not define it inline ex. `"teal-10"` `eventcolor!="(date) => date[9] % 2 === 0 ? 'teal' : 'orange'"`
"""
function datepicker(
                    fieldname::Union{Symbol,Nothing} = nothing,
                    args...;
                    mask::String = "YYYY-MM-DD",
                    content::Union{String,Vector,Function} = "",
                    kwargs...)
  q__date([isa(content, Function) ? content() : join(content)],
          args...;
          kw([:fieldname => fieldname, :mask => mask, kwargs...])...
  )
end

datepicker( content::Union{Vector,Function},
            fieldname::Union{Symbol,Nothing} = nothing,
            args...;
            mask::String = "YYYY-MM-DD",
            kwargs...) = datepicker(fieldname, args...; mask = mask, content = content, kwargs...)

mutable struct DatePicker
  fieldname
  args
  mask
  content
  kwargs

  DatePicker( fieldname::Union{Symbol,Nothing} = nothing,
              args...;
              mask::String = "YYYY-MM-DD",
              content::Union{String,Vector,Function} = "",
              kwargs...) = new(fieldname, args, mask, kwargs)
end

Base.string(dp::DatePicker) = datepicker(dp.fieldname, dp.args...; dp.mask, dp.content, dp.kwargs...)

# rendering and parsing internals

function Stipple.render(dr::DateRange, _::Union{Symbol,Nothing} = nothing)
  Dict(:from => dr.start, :to => dr.stop)
end

function Stipple.render(vdr::Vector{DateRange}, _::Union{Symbol,Nothing} = nothing)
  [ Dict(:from => dr.start, :to => dr.stop) for dr in vdr ]
end

function Stipple.stipple_parse(::Type{DateRange}, d::Dict{String,Any})
  DateRange(Date(d["from"]), Date(d["to"]))
end

end
