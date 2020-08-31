module Dashboard

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element

export dashboard

Genie.Renderer.Html.register_normal_element("st__dashboard", context = @__MODULE__)

function dashboard( args...;
                    wrap::Function = StippleUI.DEFAULT_WRAPPER,
                    kwargs...)

  wrap() do
    st__dashboard(args...; kwargs...)
  end
end

function dashboard(elemid, content::Union{String,Vector}; partial::Bool = false, title::String = "Stipple Dashboard", class::String = "", style::String = "", kwargs...)
  content = if isa(content, Vector)
    push!(pushfirst!(content, "<st-dashboard>"), "</st-dashboard>")
  else
    string("<st-dashboard>", content, "</st-dashboard>")
  end
  kwargs = NamedTuple(delete!(Dict(kwargs...), :id), :id, elemid)

  Stipple.layout(Genie.Renderer.Html.div(content; kwargs...), partial=partial, title=title, class=class, style=style)
end

end
