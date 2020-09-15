module Toggle

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template

export toggle

Genie.Renderer.Html.register_normal_element("q__toggle", context = @__MODULE__)

function toggle(label::String = "",
                fieldname::Union{Symbol,Nothing} = nothing,
                args...;
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                kwargs...)

  wrap() do
    q__toggle(args...; attributes(
      [:label => label, :fieldname => fieldname, kwargs...],
      Dict("fieldname" => "v-model", "keepcolor" => "keep-color", "leftlabel" => "left-label",
            "toggleindeterminate" => "toggle-indeterminate", "falsevalue" => "false-value", "truevalue" => "true-value",
            "iconcolor" => "icon-color", "uncheckedicon" => "unchecked-icon", "checkedicon" => "checked-icon",
            "toggleorder" => "toggle-order", "indeterminateicon" => "indeterminate-icon", "indeterminatevalue" => "indeterminate-value")
    )...)
  end
end

end
