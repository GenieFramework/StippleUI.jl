module BigNumbers

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export bignumber

Genie.Renderer.Html.register_normal_element("st__big__number", context = @__MODULE__)

"""
bignumber(label::String = "",
          number::Union{Symbol,Number,Nothing} = nothing,
          args...;
          kwargs...)

Renders a Big Number UI element.

# Arguments
* label::Union{String,Symbol}
* number::Union{String,Symbol,Nothing,String}
* icon::Union{String,Symbol}
* color::Union{String,Symbol} = "positive"|"negative"
* arrow::Union{String,Symbol} = "up"|"down"
"""
function bignumber( label::Union{String,Symbol} = "",
                    number::Union{Symbol,Number,Nothing,String} = nothing,
                    args...;
                    wrap::Function = StippleUI.DEFAULT_WRAPPER,
                    kwargs...)
  wrap() do
    st__big__number(args...; attributes([:title => label, :number => number, kwargs...])...)
  end
end

end
