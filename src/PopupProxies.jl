module PopupProxies

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template

using Stipple

export popup_proxy, PopupProxy

function __init__()
  Genie.Renderer.Html.register_normal_element("q__popup__proxy", context = Genie.Renderer.Html)
end

"""
    popup_proxy()

Renders a popup.
"""
function popup_proxy(
                      fieldname::Union{Symbol,Nothing} = nothing,
                      args...;
                      content::Union{String,Vector,Function} = "",
                      kwargs...)

  Genie.Renderer.Html.q__popup__proxy([isa(content, Function) ? content() : join(content)],
                    args...;
                    attributes(
                              [
                                :fieldname => fieldname,
                                kwargs...
                              ], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
end

popup_proxy(content::Union{Vector,Function},
            fieldname::Union{Symbol,Nothing} = nothing,
            args...;
            kwargs...) = popup_proxy(fieldname, args...; content, kwargs...)

mutable struct PopupProxy
  fieldname
  args
  content
  kwargs

  PopupProxy( fieldname::Union{Symbol,Nothing} = nothing,
              args...;
              content::Union{String,Vector,Function} = "",
              kwargs...) = new(fieldname, args, content, kwargs)
end

Base.string(pp::PopupProxy) = popup_proxy(pp.fieldname, pp.args...; pp.content, pp.kwargs...)

end
