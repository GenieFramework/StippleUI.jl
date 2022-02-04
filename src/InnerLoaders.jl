module InnerLoaders

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export innerloader

register_normal_element("q__inner__loading", context = @__MODULE__)

function innerloader(label::String = "",
                          state::Union{Symbol,Nothing} = nothing,
                          args...;
                          kwargs...)

  q__inner__loading(  args...;
            attributes(
                      [ Symbol(":state") => state,
                        :label => label,
                        kwargs...
                      ], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
end

end
