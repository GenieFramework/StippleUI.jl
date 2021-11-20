module PopupProxies

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template, register_normal_element

using Stipple

export popup_proxy, PopupProxy, popupproxy

register_normal_element("q__popup__proxy", context = @__MODULE__)

"""
    popup_proxy()

Renders a popup.
"""
function popup_proxy(
                      fieldname::Union{Symbol,Nothing} = nothing,
                      args...;
                      content::Union{String,Vector,Function} = "",
                      kwargs...)

  q__popup__proxy([isa(content, Function) ? content() : join(content)],
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

const popupproxy = popup_proxy

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
