module FormInput

import Genie, Stipple
import Genie.Renderer.Html: HTMLString, normal_element, template

using Stipple, StippleUI.API

export textfield, numberfield, textarea, filefield

Genie.Renderer.Html.register_normal_element("q__input", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__file", context = @__MODULE__)

function textfield( label::String = "",
                    fieldname::Union{Symbol,Nothing} = nothing,
                    args...;
                    wrap::Function = StippleUI.DEFAULT_WRAPPER,
                    kwargs...)

  wrap() do
    q__input(args...; attributes(
                        [:label => label, :fieldname => fieldname, kwargs...],
                        Dict("fieldname" => "v-model",
                              "labelcolor" => "label-color", "labelslot" => "label-slot", "stacklabel" => "stack-label",
                              "bgcolor" => "bg-color", "itemaligned" => "item-aligned",
                              "inputclass" => "input-class", "inputstyle" => "input-style",
                              "clearicon" => "clear-icon", "noerroricon" => "no-error-icon",
                              "fillmask" => "fill-mask", "reversefillmask" => "reverse-fill-mask", "unmaskedvalue" => "unmasked-value",
                              "errormessage" => "error-message", "hidehint" => "hide-hint",
                              "shadowtext" => "shadow-text",
                              "bottomslots" => "bottom-slots", "hidebottomspace" => "hide-bottom-space",
                              "rules" => ":rules", "lazyrules" => "lazy-rules", "reactiverules" => "reactive-rules",
                              )
                      )...)
  end
end


function numberfield(
                      fieldname::Union{Symbol,Nothing} = nothing,
                      args...;
                      wrap::Function = StippleUI.DEFAULT_WRAPPER,
                      kwargs...)

  kwargs = Dict{Symbol,Any}(kwargs...)
  kwargs[:type] = :number

  wrap() do
    textfield(args...;  attributes(
                          [:fieldname => fieldname, Stipple.NamedTuple(kwargs)...],
                          Dict("fieldname" => "v-model.number")
                        )...)
  end
end

function textarea(
                  fieldname::Union{Symbol,Nothing} = nothing,
                  args...;
                  wrap::Function = StippleUI.DEFAULT_WRAPPER,
                  kwargs...)

  kwargs = Dict{Symbol,Any}(kwargs...)
  kwargs[:type] = :textarea

  textfield(args...; attributes([:fieldname => fieldname, Stipple.NamedTuple(kwargs)...]))
end

function filefield(
                    fieldname::Union{Symbol,Nothing} = nothing,
                    args...;
                    label::String = "",
                    labelcolor::Union{String,Nothing} = nothing,
                    labelslot::Union{String,Nothing} = nothing,
                    bgcolor::Union{String,Nothing} = nothing,
                    inputclass::Union{String,Nothing} = nothing,
                    inputstyle::Union{String,Nothing} = nothing,
                    clearicon::Union{String,Nothing} = nothing,
                    rules::Union{String,Nothing} = nothing,
                    errormessage::Union{String,Nothing} = nothing,
                    maxfilesize::Union{String,Number,Nothing} = nothing,
                    maxtotalsize::Union{String,Number,Nothing} = nothing,
                    maxfiles::Union{String,Number,Nothing} = nothing,
                    counterlabel::Union{String,Nothing} = nothing,
                    displayvalue::Union{String,Number,Nothing} = nothing,
                    bottomslots::Bool = false,
                    stacklabel::Bool = false,
                    lazyrules::Bool = false,
                    reactiverules::Bool = false,
                    noerroricon::Bool = false,
                    hidehint::Bool = false,
                    hidebottomspace::Bool = false,
                    itemaligned::Bool = false,
                    kwargs...)

  k = (:label, )
  v = Any[label]

  if fieldname !== nothing
    k = (k..., Symbol("v-model"))
    push!(v, fieldname)
  end

  if labelcolor !== nothing
    k = (k..., Symbol("label-color"))
    push!(v, labelcolor)
  end

  if labelslot !== nothing
    k = (k..., Symbol("label-slot"))
    push!(v, labelslot)
  end

  if bgcolor !== nothing
    k = (k..., Symbol("bg-color"))
    push!(v, bgcolor)
  end

  if inputclass !== nothing
    k = (k..., Symbol("input-class"))
    push!(v, inputclass)
  end

  if inputstyle !== nothing
    k = (k..., Symbol("input-style"))
    push!(v, inputstyle)
  end

  if clearicon !== nothing
    k = (k..., Symbol("clear-icon"))
    push!(v, clearicon)
  end

  if rules !== nothing
    k = (k..., Symbol(":rules"))
    push!(v, rules)
  end

  if errormessage !== nothing
    k = (k..., Symbol("error-message"))
    push!(v, errormessage)
  end

  if maxfilesize !== nothing
    k = (k..., Symbol("max-file-size"))
    push!(v, maxfilesize)
  end

  if maxtotalsize !== nothing
    k = (k..., Symbol("max-total-size"))
    push!(v, maxtotalsize)
  end

  if maxfiles !== nothing
    k = (k..., Symbol("max-files"))
    push!(v, maxfiles)
  end

  if counterlabel !== nothing
    k = (k..., Symbol("counter-label"))
    push!(v, counterlabel)
  end

  if displayvalue !== nothing
    k = (k..., Symbol("display-value"))
    push!(v, displayvalue)
  end

  if bottomslots
    k = (k..., Symbol("bottom-slots"))
    push!(v, true)
  end

  if stacklabel
    k = (k..., Symbol("stack-label"))
    push!(v, true)
  end

  if lazyrules
    k = (k..., Symbol("lazy-rules"))
    push!(v, true)
  end

  if reactiverules
    k = (k..., Symbol("reactive-rules"))
    push!(v, true)
  end

  if noerroricon
    k = (k..., Symbol("no-error-icon"))
    push!(v, true)
  end

  if hidehint
    k = (k..., Symbol("hide-hint"))
    push!(v, true)
  end

  if hidebottomspace
    k = (k..., Symbol("hide-bottom-space"))
    push!(v, true)
  end

  if itemaligned
    k = (k..., Symbol("item-aligned"))
    push!(v, true)
  end

  template() do
    q__file(args...; kwargs..., NamedTuple{k}(v)...)
  end
end

end
