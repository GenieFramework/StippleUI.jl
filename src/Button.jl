module Button

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export btn, btngroup

Genie.Renderer.Html.register_normal_element("q__btn", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__btn__group", context = @__MODULE__)

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

function btn( content::Function,
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

const button = btn


function btngroup(args...;
                    wrap::Function = StippleUI.DEFAULT_WRAPPER,
                    kwargs...)
  wrap() do
    q__btn__group(args...; kwargs...)
  end
end

const buttongroup = btngroup

end
