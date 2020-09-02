module Button

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export button, buttongroup

Genie.Renderer.Html.register_normal_element("q__btn", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__btn__group", context = @__MODULE__)

function button(label::String = "",
                args...;
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                kwargs...)

  wrap() do
    q__btn(args...; attributes([:label => label, kwargs...],
                                Dict("iconright" => "icon-right", "textcolor" => "text-color",
                                      "stacked" => "stack", "nocaps" => "no-caps", "darkpercentage" => "dark-percentage"))...)
  end
end


function buttongroup(args...;
                    wrap::Function = StippleUI.DEFAULT_WRAPPER,
                    kwargs...)
  wrap() do
    q__btn__group(args...; kwargs...)
  end
end

end
