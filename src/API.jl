module API

using Stipple

export attributes

const ATTRIBUTES_MAPPINGS = Dict{String,String}(
  "autoclose" => "auto-close",
  "bgcolor" => "bg-color",
  "bottomslots" => "bottom-slots",
  "checkedicon" => "checked-icon",
  "clearicon" => "clear-icon",
  "contentclass" => "content-class",
  "contentstyle" => "content-style",
  "darkpercentage" => "dark-percentage",
  "dragonlyrange" => "drag-only-range",
  "dragrange" => "drag-range",
  "errormessage" => "error-message",
  "falsevalue" => "false-value",
  "fieldname" => "v-model",
  "fillmask" => "fill-mask",
  "fullheight" => "full-height",
  "fullwidth" => "full-width",
  "hidebottom" => "hide-bottom",
  "hidebottomspace" => "hide-bottom-space",
  "hideheader" => "hide-header",
  "hidehint" => "hide-hint",
  "iconcolor" => "icon-color",
  "iconremove" => "icon-remove",
  "iconright" => "icon-right",
  "indeterminateicon" => "indeterminate-icon",
  "indeterminatevalue" => "indeterminate-value",
  "inputclass" => "input-class",
  "inputstyle" => "input-style",
  "insetlevel" => "inset-level",
  "itemaligned" => "item-aligned",
  "keepcolor" => "keep-color",
  "labelalways" => "label-always",
  "labelcolor" => "label-color",
  "labelslot" => "label-slot",
  "labelvalue" => "label-value",
  "labelvalueleft" => "left-label-value",
  "labelvalueright" => "right-label-value",
  "lazyrules" => "lazy-rules",
  "leftlabel" => "left-label",
  "manualfocus" => "manual-focus",
  "multiline" => "multi-line",
  "nobackdrop" => "no-backdrop-dismiss",
  "nocaps" => "no-caps",
  "noerrorfocus" => "no-error-focus",
  "noerroricon" => "no-error-icon",
  "noesc" => "no-esc-dismiss",
  "nofocus" => "no-focus",
  "norefocus" => "no-refocus",
  "noresetfocus" => "no-reset-focus",
  "nowrap" => "no-wrap",
  "pagination" => ":pagination.sync",
  "reactiverules" => "reactive-rules",
  "reversefillmask" => "reverse-fill-mask",
  "rules" => ":rules",
  "selected" => ":selected.sync",
  "shadowtext" => "shadow-text",
  "stacked" => "stack",
  "stacklabel" => "stack-label",
  "textcolor" => "text-color",
  "toggleindeterminate" => "toggle-indeterminate",
  "toggleorder" => "toggle-order",
  "transitionhide" => "transition-hide",
  "transitionshow" => "transition-show",
  "truevalue" => "true-value",
  "uncheckedicon" => "unchecked-icon",
  "unmaskedvalue" => "unmasked-value",
  "vripple" => "v-ripple",
);


function attributes(kwargs::Vector{X},
                    mappings::Dict{String,String} = Dict{String,String}())::NamedTuple where {X}

  attrs = Dict()
  mapped = false

  for (k,v) in Dict(kwargs)
    v === nothing && continue
    mapped = false

    if haskey(mappings, string(k))
      k = mappings[string(k)]
    end

    attr_key = string((isa(v, Symbol) && ! startswith(string(k), ":") && ! startswith(string(k), "v-") ? ":" : ""), "$k") |> Symbol
    attr_val = isa(v, Symbol) && ! startswith(string(k), ":") ? Stipple.julia_to_vue(v) : v

    attrs[attr_key] = attr_val
  end

  NamedTuple(attrs)
end


function __init__() :: Nothing
  Stipple.rendering_mappings(ATTRIBUTES_MAPPINGS)

  nothing
end

end