module Icons

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export icon

register_normal_element("q__icon", context = @__MODULE__)

function icon(name::Union{String,Symbol},
              args...;
              content::Union{String,Vector,Function} = "",
              kwargs...)

  q__icon([isa(content, Function) ? content() : join(content)], args...; name = name, kw(kwargs)...)
end

icon( content::Union{Vector,Function},
      args...;
      name::Union{Symbol,String} = "",
      kwargs...) = icon(name, args...; content, kwargs...)

end
