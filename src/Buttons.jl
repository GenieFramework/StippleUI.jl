module Buttons

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export btn, btngroup, Btn

register_normal_element("q__btn", context = @__MODULE__)
register_normal_element("q__btn__group", context = @__MODULE__)

function btn( label::String = "",
              args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              content::Union{String,Vector,Function} = "",
              kwargs...)

  wrap() do
    q__btn([isa(content, Function) ? content() : join(content)],
            args...;
            attributes([:label => label, kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

function btn( content::Union{Function,Vector},
              label::String = "",
              args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              kwargs...)
  btn(label, args...; wrap = wrap, content = content, kwargs...)
end

function btn( args...;
              label::String = "",
              content::Union{String,Vector,Function} = "",
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              kwargs...)
  btn(label, args...; wrap = wrap, content = content, kwargs...)
end


mutable struct Btn
  label
  args
  wrap
  content
  kwargs

  Btn(label::String = "",
      args...;
      wrap::Function = StippleUI.DEFAULT_WRAPPER,
      content::Union{String,Vector,Function} = "",
      kwargs...) = new(fieldname, args, wrap, mask, kwargs)
end

Base.string(bt::Btn) = string(bt.label, bt.args...; bt.wrap, bt.content, bt.kwargs...)


function btngroup(args...;
                    wrap::Function = StippleUI.DEFAULT_WRAPPER,
                    kwargs...)
  wrap() do
    Genie.Renderer.Html.q__btn__group(args...; kwargs...)
  end
end

end
