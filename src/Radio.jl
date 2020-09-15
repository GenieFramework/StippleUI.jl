module Radio

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template

export radio

Genie.Renderer.Html.register_normal_element("q__radio", context = @__MODULE__)

function radio( label::String = "",
                fieldname::Union{Symbol,Nothing} = nothing,
                args...;
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                kwargs...)

  wrap() do
    q__radio(args...; attributes(
      [:label => label, :fieldname => fieldname, kwargs...],
      Dict("fieldname" => "v-model", "keepcolor" => "keep-color", "leftlabel" => "left-label")
    )...)
  end
end

end
