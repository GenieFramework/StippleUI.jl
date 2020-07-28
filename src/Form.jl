module Form

using Revise

import Genie, Stipple
import Genie.Renderer.Html: HTMLString, normal_element, template_

using Stipple, StippleUI.API

export form

Genie.Renderer.Html.register_normal_element("q__form", context = @__MODULE__)

function form(args...;
              noerrorfocus::Bool = false,
              noresetfocus::Bool = false,
              kwargs...)

  k = (:autofocus, )
  v = Any["autofocus"]

  if noerrorfocus
    k = (k..., Symbol("no-error-focus"))
    push!(v, true)
  end

  if noresetfocus
    k = (k..., Symbol("no-reset-focus"))
    push!(v, true)
  end

  template_() do
    q__form(args...; kwargs..., NamedTuple{k}(v)...)
  end
end

end