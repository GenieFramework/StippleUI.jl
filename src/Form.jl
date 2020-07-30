module Form

using Revise

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

using Stipple, StippleUI.API

export form

Genie.Renderer.Html.register_normal_element("q__form", context = @__MODULE__)

function form(args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              noresetfocus::Bool = false,
              kwargs...)

  wrap() do
    q__form(args...; attributes([kwargs...],
                                Dict("noerrorfocus" => "no-error-focus", "noresetfocus" => "no-reset-focus"))...)
  end
end

end