module FormInputs

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template, register_normal_element

export textfield, numberfield, textarea, filefield

register_normal_element("q__input", context = @__MODULE__)
register_normal_element("q__file", context = @__MODULE__)

"""
    textfield(fieldname, args...; kwargs...)

----------
# Examples
----------

### Model

```julia-repl
julia> @reactive! mutable struct TextField <: ReactiveModel
          name::R{String} = ""
       end
```

### View
```julia-repl
julia> textfield("What's your name *", :name, name = "name", @iif(:warin), :filled, hint = "Name and surname", "lazy-rules",
          rules = "[val => val && val.length > 0 || 'Please type something']"
       )
```

----------
# Arguments
----------

* `type::String` - Must be one of the following: `text (default)`, `textarea`, `email`, `tel`, `number`, `password` and `url`. This is important as it determines the keyboard type popping up on mobile devices.
* `readonly::Bool` - If set to `true`, textfield is readonly and the user cannot change value.
* `clearable::Bool` - If set to `true`, the component offers the user an actionable icon to remove the entered text.

When you set type to “number”, there are some additional properties that you can use:

* 
"""
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
