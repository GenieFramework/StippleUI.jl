module API

using Stipple, StippleUI, Colors
import Genie.Renderer.Html: HTMLString, normal_element

export attributes, quasar, vue, quasar_pure, vue_pure, xelem, xelem_pure, csscolors

const ATTRIBUTES_MAPPINGS = Dict{String,String}(
  "activebgcolor" => "active-bg-color",
  "activeclass" => "active-class",
  "activecolor" => "active-color",
  "alert" => "alert",
  "alerticon" => "alert-icon",
  "align" => "align",
  "append" => "append",
  "autoclose" => "auto-close",
  "bgcolor" => "bg-color",
  "bottomslots" => "bottom-slots",
  "breakpoint" => "breakpoint",
  "checkedicon" => "checked-icon",
  "clearicon" => "clear-icon",
  "contentclass" => "content-class",
  "contentstyle" => "content-style",
  "contextmenu" => "context-menu",
  "darkpercentage" => "dark-percentage",
  "defaultyearmonth" => "default-year-month",
  "defaultview" => "default-view",
  "definitions" => ":definitions",
  "dense" => "dense",
  "disable" => "disable",
  "displayvalue" => "display-value",
  "dropnative" => "@drop.native",
  "dragonlyrange" => "drag-only-range",
  "dragrange" => "drag-range",
  "emitimmd" => "emit-immediately",
  "errormessage" => "error-message",
  "eventcolor" => "event-color",
  "exact" => "exact",
  "exactactiveclass" => "exact-active-class",
  "expandseparator" => "expand-separator",
  "falsevalue" => "false-value",
  "fieldname" => "v-model",
  "fillmask" => "fill-mask",
  "firstdayofweek" => "first-day-of-week",
  "fullheight" => "full-height",
  "fullwidth" => "full-width",
  "hidebottom" => "hide-bottom",
  "hidebottomspace" => "hide-bottom-space",
  "hideheader" => "hide-header",
  "hidehint" => "hide-hint",
  "iconcolor" => "icon-color",
  "iconremove" => "icon-remove",
  "iconright" => "icon-right",
  "imageclass" => "img-class",
  "imagestyle" => "img-style",
  "indeterminateicon" => "indeterminate-icon",
  "indeterminatevalue" => "indeterminate-value",
  "indicatorcolor" => "indicator-color",
  "inlinelabel" => "inline-label",
  "inputclass" => "input-class",
  "inputstyle" => "input-style",
  "insetlevel" => "inset-level",
  "itemaligned" => "item-aligned",
  "keepcolor" => "keep-color",
  "label" => "label",
  "labelalways" => "label-always",
  "labelcolor" => "label-color",
  "labelslot" => "label-slot",
  "labelvalue" => "label-value",
  "labelvalueleft" => "left-label-value",
  "labelvalueright" => "right-label-value",
  "lazyrules" => "lazy-rules",
  "lefticon" => "left-icon",
  "leftlabel" => "left-label",
  "manualfocus" => "manual-focus",
  "maxheight" => "max-height",
  "maxvalues" => "max-values",
  "minheight" => "min-height",
  "mobilearrows" => "mobile-arrows",
  "multiline" => "multi-line",
  "name" => "name",
  "nativecontextmenu" => "native-context-menu",
  "narrowindicator" => "narrow-indicator",
  "navmaxyearmonth" => "navigation-max-year-month",
  "navminyearmonth" => "navigation-min-year-month",
  "newvaluemode" => "new-value-mode",
  "nobackdrop" => "no-backdrop-dismiss",
  "nocaps" => "no-caps",
  "nodefaultspinner" => "no-default-spinner",
  "noerrorfocus" => "no-error-focus",
  "noerroricon" => "no-error-icon",
  "noesc" => "no-esc-dismiss",
  "nofocus" => "no-focus",
  "noparentevent" => "no-parent-event",
  "norefocus" => "no-refocus",
  "noresetfocus" => "no-reset-focus",
  "nowrap" => "no-wrap",
  "nounset" => "no-unset",
  "outsidearrows" => "outside-arrows",
  "pagination" => ":pagination.sync",
  "placeholdersrc" => "placeholder-src",
  "reactiverules" => "reactive-rules",
  "replace" => "replace",
  "reversefillmask" => "reverse-fill-mask",
  "righticon" => "right-icon",
  "ripple" => "ripple",
  "rules" => ":rules",
  "selected" => ":selected.sync",
  "shadowtext" => "shadow-text",
  "showifabove" => "show-if-above",
  "shrink" => "shrink",
  "spinnercolor" => "spinner-color",
  "spinnersize" => "spinner-size",
  "stacked" => "stack",
  "stacklabel" => "stack-label",
  "stretch" => "stretch",
  "switchindicator" => "switch-indicator",
  "tabindex" => "tabindex",
  "target" => "target",
  "textcolor" => "text-color",
  "to" => "to",
  "todaybtn" => "today-btn",
  "toggleindeterminate" => "toggle-indeterminate",
  "toggleorder" => "toggle-order",
  "toolbar" => ":toolbar",
  "toolbartextcolor" => "toolbar-text-color",
  "toolbartogglecolor" => "toolbar-toggle-color",
  "toolbarbg" => "toolbar-bg",
  "pastenative" => "@paste.native",
  "transitionhide" => "transition-hide",
  "transitionshow" => "transition-show",
  "truevalue" => "true-value",
  "uncheckedicon" => "unchecked-icon",
  "unmaskedvalue" => "unmasked-value",
  "usechips" => "use-chips",
  "useinput" => "use-input",
  "value" => "value",
  "vertical" => "vertical",
  "vripple" => "v-ripple",
  "yearsinmonthview" => "years-in-month-view"
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

    attr_key = string((isa(v, Symbol) && ! startswith(string(k), ":") &&
      ! ( startswith(string(k), "v-") || startswith(string(k), "v" * Genie.config.html_parser_char_dash) ) ? ":" : ""), "$k") |> Symbol
    attr_val = isa(v, Symbol) && ! startswith(string(k), ":") ? Stipple.julia_to_vue(v) : v

    attrs[attr_key] = attr_val
  end

  NamedTuple(attrs)
end

function q__elem(f::Function, elem::Symbol, args...; attrs...) :: HTMLString
  normal_element(f, string(elem), [args...], Pair{Symbol,Any}[attrs...])
end

function q__elem(elem::Symbol, children::Union{String,Vector{String}} = "", args...; attrs...) :: HTMLString
  normal_element(children, string(elem), [args...], Pair{Symbol,Any}[attrs...])
end

function q__elem(elem::Symbol, children::Any, args...; attrs...) :: HTMLString
  normal_element(string(children), string(elem), [args...], Pair{Symbol,Any}[attrs...])
end

function xelem(elem::Symbol, args...;
              wrap::Function = StippleUI.DEFAULT_WRAPPER,
              attributesmappings::Dict{String, String} = Dict{String, String}(),
              mergemappings = true,
              kwargs...)
  wrap() do
    q__elem(elem, args...; attributes([kwargs...], mergemappings ? merge(ATTRIBUTES_MAPPINGS, attributesmappings) : attributesmappings)...)
  end
end

function quasar(elem::Symbol, args...;
               wrap::Function = StippleUI.DEFAULT_WRAPPER,
               kwargs...)
  xelem(elem, :q, args...; wrap, kwargs...)
end

function vue(elem::Symbol, args...;
            wrap::Function = StippleUI.DEFAULT_WRAPPER,
            kwargs...)
  xelem(elem, :vue, args...; wrap, kwargs...)
end

xelem(elem::Symbol, prefix::Symbol, args...; kwargs...) = xelem(Symbol("$prefix-$elem"), args...; kwargs...)
xelem_pure(elem::Symbol, args...; kwargs...) = xelem(elem, args...; wrap = StippleUI.NO_WRAPPER, kwargs...)
quasar_pure(elem::Symbol, args...; kwargs...) = quasar(elem, args...; wrap = StippleUI.NO_WRAPPER, kwargs...)
vue_pure(elem::Symbol, args...; kwargs...) = vue(elem, args...; wrap = StippleUI.NO_WRAPPER, kwargs...)

"""
    `csscolors(name, color)`
    `csscolors(names, colors)`
    `csscolors(prefix, colors)`

Construct a css string that defines colors to be used for styling quasar elements.
# Usage
css = styles(csscolors(:stipple, [RGB(0.2, 0.4, 0.8), "#123456", RGBA(0.1, 0.2, 0.3, 0.5)]))

ui() = css * dashboard(vm(model), class="container", [
  btn("Hit me", @click(:pressed), color="stipple-3")
])
"""
function csscolors(name, color::AbstractString)
  ".text-$name { color: $color }\n.bg-$name   { background: $color !important}"
end

csscolors(name, color::Colorant) = csscolors(name, "#" * hex(color, :auto))

csscolors(names::Vector, colors::Vector) = join([csscolors(n, c) for (n, c) in zip(names, colors)], "\n")

csscolors(prefix::Union{Symbol, AbstractString}, colors::Vector) = csscolors("$prefix-" .* string.(1:length(colors)), colors)

function __init__() :: Nothing
  Stipple.rendering_mappings(ATTRIBUTES_MAPPINGS)

  nothing
end

end
