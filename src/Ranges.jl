module Ranges

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template, register_normal_element

using Stipple

export range, RangeData, slider

register_normal_element("q__range", context = @__MODULE__)
register_normal_element("q__slider", context = @__MODULE__)

# we have to use UnitRange because Quasar does not send back the step so we always
# end up with a UnitRange from Quasar
# this means that we need to use UnitRange on the Julia side and do the stepping in Quasar
# so no StepRange is allowed here
Base.@kwdef mutable struct RangeData{T}
  range::UnitRange{T}
end

const QRangeType = Union{Symbol, String, Real}
struct QRange <: AbstractRange{QRangeType}
  min::QRangeType
  step::QRangeType
  max::QRangeType
end

Base.length(qr::QRange) = (qr.min isa Real && qr.step isa Real && qr.max isa Real) ? length(qr.min:qr.step:qr.max) : nothing
Base.step(qr::QRange) = qr.step
Base.first(qr::QRange) = qr.min
Base.last(qr::QRange) = qr.max

QRange(min::QRangeType, max::QRangeType) = QRange(min, 1, max)

Base.:(:)(start::Union{Symbol, String}, step::QRangeType, stop::QRangeType) = QRange(start, step, stop)
Base.:(:)(start::Real, step::Union{Symbol, String}, stop::QRangeType) = QRange(start, step, stop)
Base.:(:)(start::Real, step::Real, stop::Union{Symbol, String}) = QRange(start, step, stop)
Base.:(:)(start::Union{Symbol, String}, stop::QRangeType) = QRange(start, 1, stop)
Base.:(:)(start::Real, stop::Union{Symbol, String}) = QRange(start, 1, stop)

"""
    range(range::AbstractRange{<:Union{Symbol, String, Real}}, fieldname::Union{Symbol,Nothing} = nothing, args...; lazy = false, kwargs...)

The `range` component is a great way to offer the user the selection of a sub-range of values between a minimum and maximum value, with optional steps to select those values. An example use case for the Range component would be to offer a price range selection

----------
# Examples
----------

### Model

```julia-repl
julia> @reactive mutable struct RangeModel <: ReactiveModel
         range_data::R{RangeData{Int}} = RangeData(18:80)
       end
```

### View
```julia-repl
julia> range(18:1:90,
          :range_data;
          label=true,
          color="purple",
          labelalways=true,
          labelvalueleft=Symbol("'Min age: ' + range_data.min"),
          labelvalueright=Symbol("'Max age: ' + range_data.max")
       )
```

----------
# Arguments
----------

1. Behaviour
      * `name::String` - Used to specify the name of the control; Useful if dealing with forms submitted directly to a URL ex. `car_id`
      * `snap::Bool` - Snap on valid values, rather than sliding freely; Suggestion: use with 'step' property
      * `reverse::Bool` - Work in reverse (changes direction)
      * `vertical::Bool` - Display in vertical direction
      * `labelalways::Bool` - Always display the label
2. Content
      * `label::Bool` - Popup a label when user clicks/taps on the slider thumb and moves it
      * `markers::Union{Bool, Int}` - Display markers on the track, one for each possible value for the model or using a custom step (when specifying a Number) ex. `markers` `markers="5"`
      * `dragrange::Bool` - User can drag range instead of just the two thumbs
      * `dragonlyrange::Bool` - User can drag only the range instead and NOT the two thumbs
3. General
      * `tabindex::Union{Int, String}` - Tabindex HTML attribute value ex. `0` `100`
4. Labels
      * `labelcolorleft::String` - Color name for left label background from the [Color Palette](https://quasar.dev/style/color-palette) ex. `primary` `teal-10`
      * `labeltextcolorleft::String` - Color name for left label text from the [Color Palette](https://quasar.dev/style/color-palette) ex. `primary` `teal-10`
      * `labelcolorright::String` - Color name for right label background from the [Color Palette](https://quasar.dev/style/color-palette) ex. `primary` `teal-10`
      * `labeltextcolorright::String` - Color name for right label text from the [Color Palette](https://quasar.dev/style/color-palette) ex. `primary` `teal-10`
      * `labelvalueleft::Union{String, Int}` - Override default label for min value ex. `labelvalueleft="model.min + 'px'"`
      * `labelvalueright::Union{String, Int}` - Override default label for max value ex. `labelvalueright="model.max + 'px'"`
5. Model
      * `range::AbstractRange{T}` - The range of values to select from min:step:max, symbols or strings can be used to reference model fields, e.g. `range("min":2:"max", :myvalue)`
      * `lazy::Bool` - If true, update the value of the model field only upon release of the slider
6. State
      * `disable::Bool` - Put component in disabled mode
      * `readonly::Bool` - Put component in readonly mode
7. Style
      * `color::String` - Color name for component from the [Color Palette](https://quasar.dev/style/color-palette) ex. `primary` `teal-10`
      * `labelcolor::String` - Color name for component from the [Color Palette](https://quasar.dev/style/color-palette) ex. `primary` `teal-10`
      * `thumbpath::String` - Set custom thumb svg path ex. `M5 5 h10 v10 h-10 v-10`
      * `dark::Bool` - Notify the component that the background is a dark color
      * `dense::Bool` - Dense mode; occupies less space
"""
function Base.range(
                range::AbstractRange{<:QRangeType},
                fieldname::Union{Symbol,Nothing} = nothing,
                args...;
                lazy = false,
                kwargs...)

  if lazy
    q__range(args...;  @on(:change, "val => { $fieldname = val }"), kw([
      Symbol(":min") => first(range),
      Symbol(":max") => last(range),
      Symbol(":step") => step(range),
      :value => fieldname,
      kwargs...
    ])...)
  else
    q__range(args...; kw([
      Symbol(":min") => first(range),
      Symbol(":max") => last(range),
      Symbol(":step") => step(range),
      :fieldname => fieldname,
      kwargs...
    ])...)
  end
end

"""
    slider(range::AbstractRange{<:Union{Symbol, String, Real}}, fieldname::Union{Symbol,Nothing} = nothing, args...; lazy = false, kwargs...)

The `slider` is a great way for the user to specify a number value between a minimum and maximum value, with optional steps between valid values. The slider also has a focus indicator (highlighted slider button), which allows for keyboard adjustments of the slider.
----------
# Examples
----------

### View
```julia-repl
julia> slider(1:5:100)
```

----------
# Arguments
----------

1. Behaviour
      * `name::String` - Used to specify the name of the control; Useful if dealing with forms submitted directly to a URL ex. `car_id`
      * `snap::Bool` - Snap on valid values, rather than sliding freely; Suggestion: use with 'step' property
      * `reverse::Bool` - Work in reverse (changes direction)
      * `vertical::Bool` - Display in vertical direction
      * `labelalways::Bool` - Always display the label
2. Content
      * `label::Bool` - Popup a label when user clicks/taps on the slider thumb and moves it
      * `markers::Union{Bool, Int}` - Display markers on the track, one for each possible value for the model or using a custom step (when specifying a Number) ex. `markers` `markers="5"`
      * `dragrange::Bool` - User can drag range instead of just the two thumbs
      * `dragonlyrange::Bool` - User can drag only the range instead and NOT the two thumbs
3. General
      * `tabindex::Union{Int, String}` - Tabindex HTML attribute value ex. `0` `100`
4. Labels
      * `labelcolorleft::String` - Color name for left label background from the [Color Palette](https://quasar.dev/style/color-palette) ex. `primary` `teal-10`
      * `labeltextcolorleft::String` - Color name for left label text from the [Color Palette](https://quasar.dev/style/color-palette) ex. `primary` `teal-10`
      * `labelcolorright::String` - Color name for right label background from the [Color Palette](https://quasar.dev/style/color-palette) ex. `primary` `teal-10`
      * `labeltextcolorright::String` - Color name for right label text from the [Color Palette](https://quasar.dev/style/color-palette) ex. `primary` `teal-10`
      * `labelvalueleft::Union{String, Int}` - Override default label for min value ex. `labelvalueleft="model.min + 'px'"`
      * `labelvalueright::Union{String, Int}` - Override default label for max value ex. `labelvalueright="model.max + 'px'"`
5. Model
      * `range::AbstractRange{T}` - The range of values to select from min:step:max, symbols or strings can be used to reference model fields, e.g. `range("min":2:"max", :myvalue)`
      * `lazy::Bool` - If true, update the value of the model field only upon release of the slider
6. State
      * `disable::Bool` - Put component in disabled mode
      * `readonly::Bool` - Put component in readonly mode
7. Style
      * `color::String` - Color name for component from the [Color Palette](https://quasar.dev/style/color-palette) ex. `primary` `teal-10`
      * `labelcolor::String` - Color name for component from the [Color Palette](https://quasar.dev/style/color-palette) ex. `primary` `teal-10`
      * `thumbpath::String` - Set custom thumb svg path ex. `M5 5 h10 v10 h-10 v-10`
      * `dark::Bool` - Notify the component that the background is a dark color
      * `dense::Bool` - Dense mode; occupies less space
"""
function slider(range::AbstractRange{<:QRangeType},
                fieldname::Union{Symbol, Nothing} = nothing,
                args...;
                lazy = false,
                kwargs...)

  if lazy
    q__slider(args..., @on(:change, "val => { $fieldname = val }"); kw([
            Symbol(":min") => first(range),
            Symbol(":max") => last(range),
            Symbol(":step") => step(range),
            :value => fieldname,
            kwargs...
    ])...)
  else
    q__slider(args...; kw([
            Symbol(":min") => first(range),
            Symbol(":max") => last(range),
            Symbol(":step") => step(range),
            :fieldname => fieldname,
            kwargs...
    ])...)
  end
end

function Stipple.render(rd::RangeData{T}, fieldname::Union{Symbol,Nothing} = nothing) where {T}
  Dict(:min => rd.range.start, :max => rd.range.stop)
end

function Base.parse(::Type{RangeData{T}}, d::Dict{X,Y}) where {T,X,Y}
  RangeData(d["min"]:d["max"])
end

end
