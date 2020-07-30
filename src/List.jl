module List

using Revise

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export list, item, item_section, item_label

Genie.Renderer.Html.register_normal_element("q__list", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__item", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__item__section", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__item__label", context = @__MODULE__)

function list(args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              kwargs...)
  wrap() do
    q__list(args...; kwargs...)
  end
end


function item(args...; kwargs...)
  q__item(args...; attributes([kwargs...],
                              Dict("vripple" => "v-ripple", "insetlevel" => "inset-level", "manualfocus" => "manual-focus"))...)
end


function item_section(args...; kwargs...)
  q__item__section(args...; attributes([kwargs...], Dict("nowrap" => "no-wrap"))...)
end


function item_label(args...; kwargs...)
  q__item__label(args...; kwargs...)
end

end