module Dashboards

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

register_normal_element("st__dashboard", context = @__MODULE__)

export dashboard

function dashboard( args...;
                    wrap::Function = StippleUI.DEFAULT_WRAPPER,
                    kwargs...)

  wrap() do
    st__dashboard(args...; kwargs...)
  end
end


const tagname = "st-dashboard"

function dashboard(elemid, content::Union{String,Vector}; partial::Bool = true, title::String = "Stipple Dashboard", head_content::String = "",
                    class::String = "", style::String = "", channel::String = Genie.config.webchannels_default_route, kwargs...)
  content = if isa(content, Vector)
    push!(pushfirst!(content, "<$tagname>"), "</$tagname>")
  else
    string("<$tagname>", content, "</$tagname>")
  end

  kwargs = NamedTuple(delete!(Stipple.OptDict(kwargs...), :id), :id, elemid)

  Stipple.layout(Genie.Renderer.Html.div(content; kwargs...); partial=partial, title=title, class=class,
                                                              head_content=head_content, style=style, channel=channel)
end

end
