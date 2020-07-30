module Badge

using Revise

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export badge

Genie.Renderer.Html.register_normal_element("q__badge", context = @__MODULE__)

function badge( label::String = "",
                fieldname::Union{Symbol,Nothing} = nothing,
                args...;
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                kwargs...)
  wrap() do
    q__badge(args...;
            attributes(
              [:label => label, :fieldname => fieldname, kwargs...],
              Dict("fieldname" => "v-model", "textcolor" => "text-color", "multiline" => "multi-line"))...)
  end
end

end