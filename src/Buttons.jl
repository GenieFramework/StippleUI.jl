module Buttons

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export btn, btngroup, btndropdown, Btn

register_normal_element("q__btn", context = @__MODULE__)
register_normal_element("q__btn__group", context = @__MODULE__)
register_normal_element("q__btn__dropdown", context = @__MODULE__)

function btn( label::String = "",
              args...;
              content::Union{String,Vector,Function} = "",
              kwargs...)
  q__btn([isa(content, Function) ? content() : join(content)],
          args...;
          kw(kwargs)...
  )
end

function btn( content::Union{Function,Vector},
              label::String = "",
              args...;
              kwargs...)
  btn(label, args...; content = content, kwargs...)
end

function btn( args...;
              label::String = "",
              content::Union{String,Vector,Function} = "",
              kwargs...)
  btn(label, args...; content = content, kwargs...)
end


mutable struct Btn
  label
  args
  wrap
  content
  kwargs

  Btn(label::String = "",
      args...;
      content::Union{String,Vector,Function} = "",
      kwargs...) = new(fieldname, args, mask, kwargs)
end

Base.string(bt::Btn) = btn(bt.label, bt.args...; bt.content, bt.kwargs...)


function btngroup(args...; kwargs...)
  q__btn__group(args...; kw(kwargs)...)
end


function btndropdown(args...; kwargs...)
  q__btn__dropdown(args...; kw(kwargs)...)
end


end
