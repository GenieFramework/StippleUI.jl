module Icons

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export icon

function __init__()
  Genie.Renderer.Html.register_normal_element("q__icon", context = Genie.Renderer.Html)
end

function icon(name::Union{String,Symbol},
              args...;
              content::Union{String,Vector,Function} = "",
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              kwargs...)

  wrap() do
    Genie.Renderer.Html.q__icon([isa(content, Function) ? content() : join(content)], args...; attributes([:name => name, kwargs...])...)
  end
end

icon( content::Union{Vector,Function},
      args...;
      wrap::Function = StippleUI.DEFAULT_WRAPPER,
      name::Union{Symbol,String} = "",
      kwargs...) = icon(name, args...; content, wrap, kwargs...)

end
