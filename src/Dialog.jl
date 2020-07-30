module Dialog

using Revise

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export dialog

Genie.Renderer.Html.register_normal_element("q__dialog", context = @__MODULE__)

function dialog(args...;
                wrap::Function = StippleUI.DEFAULT_WRAPPER,
                kwargs...)

  wrap() do
    q__dialog(args...; attributes([kwargs...],
                                  Dict( "nobackdrop" => "no-backdrop-dismiss", "autoclose" => "auto-close",
                                        "noesc" => "no-esc-dismiss", "transitionshow" => "transition-show",
                                        "transitionhide" => "transition-hide", "norefocus" => "no-refocus",
                                        "nofocus" => "no-focus", "fullwidth" => "full-width", "fullheight" => "full-height",
                                        "contentclass" => "content-class", "contentstyle" => "content-style"))...)
  end
end

end