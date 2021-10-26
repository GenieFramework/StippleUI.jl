module FormInputs

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template

export textfield, numberfield, textarea, filefield

function __init__()
  Genie.Renderer.Html.register_normal_element("q__input", context = Genie.Renderer.Html)
  Genie.Renderer.Html.register_normal_element("q__file", context = Genie.Renderer.Html)
end

function textfield( label::String = "",
                    fieldname::Union{Symbol,Nothing} = nothing,
                    args...;
                    content::Union{String,Vector,Function} = "",
                    wrap::Function = StippleUI.DEFAULT_WRAPPER,
                    kwargs...)
  wrap() do
    Genie.Renderer.Html.q__input([isa(content, Function) ? content() : join(content)],
              args...;
              attributes([:label => label,
                          :fieldname => fieldname,
                          kwargs...],
                          StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end

textfield(content::Union{Vector,Function},
          fieldname::Union{Symbol,Nothing} = nothing,
          args...;
          wrap::Function = StippleUI.DEFAULT_WRAPPER,
          label::String = "",
          kwargs...) = textfield(label, fieldname, args...; content, wrap, kwargs...)

function numberfield( label::String = "",
                      fieldname::Union{Symbol,Nothing} = nothing,
                      args...;
                      content::Union{String,Vector,Function} = "",
                      wrap::Function = StippleUI.DEFAULT_WRAPPER,
                      kwargs...)
  wrap() do
    Genie.Renderer.Html.q__input( [isa(content, Function) ? content() : join(content)],
              args...;
              attributes([:label => label,
                          :fieldname => fieldname, kwargs...],
                          merge(StippleUI.API.ATTRIBUTES_MAPPINGS, Dict("fieldname" => "v-model.number"))
                        )...)
  end
end

function textarea(label::String = "",
                  fieldname::Union{Symbol,Nothing} = nothing,
                  args...;
                  content::Union{String,Vector,Function} = "",
                  wrap::Function = StippleUI.DEFAULT_WRAPPER,
                  kwargs...)

  textfield(label, fieldname, args...; type="textarea", wrap=wrap, content=content, kwargs...)
end

function filefield( label::String = "",
                    fieldname::Union{Symbol,Nothing} = nothing,
                    args...;
                    wrap::Function = StippleUI.DEFAULT_WRAPPER,
                    kwargs...)

  wrap() do
    Genie.Renderer.Html.q__file(args...;
            attributes(
                        [:label => label, :fieldname => fieldname, kwargs...],
                        Dict("fieldname" => "v-model",
                              "itemaligned" => "item-aligned", "stacklabel" => "stack-label", "bottomslots" => "bottom-slots",
                              "hidebottomspace" => "hide-bottom-space", "hidehint" => "hide-hint", "displayvalue" => "display-value",
                              "reactiverules" => "reactive-rules", "lazyrules" => "lazy-rules", "rules" => ":rules",
                              "counterlabel" => "counter-label", "maxfiles" => "max-files", "maxtotalsize" => "max-total-size", "maxfilesize" => "max-file-size",
                              "errormessage" => "error-message", "noerroricon" => "no-error-icon", "clearicon" => "clear-icon",
                              "inputstyle" => "input-style", "inputclass" => "input-class", "bgcolor" => "bg-color",
                              "labelslot" => "label-slot", "labelcolor" => "label-color"
                              )
                      )...)
  end
end

end
