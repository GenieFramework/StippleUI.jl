module Spinners

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export spinner

register_normal_element("q__spinner", context = @__MODULE__)

for spinner in ["audio", "ball", "bars", "box", "clock", "comment", "cube", "dots", "facebook", "gears", "grid",
                "hearts", "hourglass", "infinity", "ios", "orbit", "oval", "pie", "puff", "radio", "rings", "tail"]
  register_normal_element("q__spinner__$spinner", context = @__MODULE__)
end

function spinner(spinner_type::Union{String,Symbol} = "",
                  args...;
                  wrap::Function = StippleUI.DEFAULT_WRAPPER,
                  kwargs...)

  wrap() do
    getfield(Genie.Renderer.Html, Symbol("q__spinner$(isempty(string(spinner_type)) ? "" : "__")$spinner_type"))(args...; kwargs...)
  end
end

end
