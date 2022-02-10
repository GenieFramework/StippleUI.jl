module FormInputs

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template, register_normal_element

export textfield, numberfield, textarea, filefield

register_normal_element("q__input", context = @__MODULE__)
register_normal_element("q__file", context = @__MODULE__)

function textfield( label::String = "",
                    fieldname::Union{Symbol,Nothing} = nothing,
                    args...;
                    content::Union{String,Vector,Function} = "",
                    kwargs...)
  q__input([isa(content, Function) ? content() : join(content)],
            args...;
            kw([:label => label, :fieldname => fieldname, kwargs...])...)
end

textfield(content::Union{Vector,Function},
          fieldname::Union{Symbol,Nothing} = nothing,
          args...;
          label::String = "",
          kwargs...) = textfield(label, fieldname, args...; content, kwargs...)

function numberfield( label::String = "",
                      fieldname::Union{Symbol,Nothing} = nothing,
                      args...;
                      content::Union{String,Vector,Function} = "",
                      kwargs...)
  q__input( [isa(content, Function) ? content() : join(content)],
            args...;
            kw(
              [:label => label, :fieldname => fieldname, kwargs...],
              Dict("fieldname" => "v-model.number"))...
            )
end

function textarea(label::String = "",
                  fieldname::Union{Symbol,Nothing} = nothing,
                  args...;
                  content::Union{String,Vector,Function} = "",
                  kwargs...)
  textfield(label, fieldname, args...; type="textarea", content=content, kwargs...)
end

function filefield( label::String = "",
                    fieldname::Union{Symbol,Nothing} = nothing,
                    args...;
                    kwargs...)

  q__file(args...;
          kw(
            [:label => label, :fieldname => fieldname, kwargs...],
            Dict("maxfiles" => "max-files", "maxfilesize" => "max-file-size",
                 "counterlabel" => "counter-label", "maxtotalsize" => "max-total-size"
            )
          )...)
end

end
