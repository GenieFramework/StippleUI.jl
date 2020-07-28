module Dialog

using Revise

import Genie, Stipple
import Genie.Renderer.Html: HTMLString, normal_element, template_

using Stipple, StippleUI.API

export dialog

Genie.Renderer.Html.register_normal_element("q__dialog", context = @__MODULE__)

function dialog(args...;
                noesc::Bool = false,
                nobackdrop::Bool = false,
                autoclose::Bool = false,
                transition_show::Union{String,Nothing} = nothing,
                transition_hide::Union{String,Nothing} = nothing,
                norefocus::Bool = false,
                nofocus::Bool = false,
                fullwidth::Bool = false,
                fullheight::Bool = false,
                contentclass::Union{String,Nothing} = nothing,
                contentstyle::Union{String,Nothing} = nothing,
                kwargs...)

  k = (:position, )
  v = Any["standard"]

  if nobackdrop
    k = (k..., Symbol("no-backdrop-dismiss"))
    push!(v, true)
  end

  if autoclose
    k = (k..., Symbol("auto-close"))
    push!(v, true)
  end

  if transition_show !== nothing
    k = (k..., Symbol("transition-show"))
    push!(v, transition_show)
  end

  if transition_hide !== nothing
    k = (k..., Symbol("transition-hide"))
    push!(v, transition_hide)
  end

  if norefocus
    k = (k..., Symbol("no-refocus"))
    push!(v, true)
  end

  if nofocus
    k = (k..., Symbol("no-focus"))
    push!(v, true)
  end

  if fullwidth
    k = (k..., Symbol("full-width"))
    push!(v, true)
  end

  if fullheight
    k = (k..., Symbol("full-height"))
    push!(v, true)
  end

  if contentclass !== nothing
    k = (k..., Symbol("content-class"))
    push!(v, contentclass)
  end

  if contentstyle !== nothing
    k = (k..., Symbol("content-style"))
    push!(v, contentstyle)
  end

  template_() do
    q__dialog(args...; kwargs..., NamedTuple{k}(v)...)
  end
end

end