module Icon

using Revise

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export icon

Genie.Renderer.Html.register_normal_element("q__icon", context = @__MODULE__)

function icon(name::Union{String,Symbol},
              args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              kwargs...)

  wrap() do
    q__icon(args...; attributes([:name => name, kwargs...])...)
  end
end

end