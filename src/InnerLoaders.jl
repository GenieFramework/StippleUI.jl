module InnerLoaders

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export innerloader

register_normal_element("q__inner__loading", context = @__MODULE__)

function innerloader(label::Union{String,Symbol,Nothing} = nothing,
                          state::Union{Symbol,Nothing} = nothing,
                          args...;
                          kwargs...)

  q__inner__loading(  args...; state = state, label = label, kw(kwargs)...)
end

end
