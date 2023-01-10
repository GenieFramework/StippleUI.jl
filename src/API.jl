module API

using Stipple, StippleUI, Colors
import Genie.Renderer.Html: HTMLString, normal_element

export quasar, vue, quasar_pure, vue_pure, xelem, xelem_pure, csscolors, kw, @kw

const ATTRIBUTES_MAPPINGS = Dict{String,String}(
  "activeclass" => "active-class",
  "activecolor" => "active-color",
  "activecolorbg" => "active-bg-color",
  "alerticon" => "alert-icon",
  "autoclose" => "auto-close",
  "autoupload" => "auto-upload",
  "barstyle" => "bar-style",
  "bgcolor" => "bg-color",
  "bottomslots" => "bottom-slots",
  "captionlines" => "caption-lines",
  "checkedicon" => "checked-icon",
  "classafter" => "after-class",
  "classbefore" => "before-class",
  "clearicon" => "clear-icon",
  "colorhalf" => "color-half",
  "colorselected" => "color-selected",
  "contentclass" => "content-class",
  "contentinsetlevel" => "content-inset-level",
  "contentstyle" => "content-style",
  "contextmenu" => "context-menu",
  "darkpercentage" => "dark-percentage",
  "defaultdate" => "default-date",
  "defaultopened" => "default-opened",
  "defaultyearmonth" => "default-year-month",
  "defaultview" => "default-view",
  "definitions" => ":definitions",
  "densetoggle" => "dense-toggle",
  "disabledropdown" => "disable-dropdown",
  "disablemainbtn" => "disable-main-btn",
  "displayvalue" => "display-value",
  "displayvaluesanitize" => "display-values-sanitize",
  "dropnative" => "@drop.native",
  "dragonlyrange" => "drag-only-range",
  "dragrange" => "drag-range",
  "dropdownicon" => "dropdown-icon",
  "emitimmd" => "emit-immediately",
  "emitvalue" => "emit-value",
  "errormessage" => "error-message",
  "eventcolor" => "event-color",
  "exactactiveclass" => "exact-active-class",
  "expandicon" => "expand-icon",
  "expandiconclass" => "expand-icon-class",
  "expandedicon" => "expanded-icon",
  "expandicontoggle" => "expand-icon-toggle",
  "expandseparator" => "expand-separator",
  "fabmini" => "fab-mini",
  "falsevalue" => "false-value",
  "fieldname" => "v-model",
  "fillmask" => "fill-mask",
  "firstdayofweek" => "first-day-of-week",
  "formfields" => "form-fields",
  "fullheight" => "full-height",
  "fullwidth" => "full-width",
  "headerinsetlevel" => "header-inset-level",
  "headerstyle" => "header-style",
  "hidebottom" => "hide-bottom",
  "hidebottomspace" => "hide-bottom-space",
  "hidedelay" => "hide-delay",
  "hidedropdownicon" => "hide-dropdown-icon",
  "hideheader" => "hide-header",
  "hidehint" => "hide-hint",
  "hideselected" => "hide-selected",
  "hideuploadbtn" => "hide-upload-btn",
  "iconcolor" => "icon-color",
  "iconhalf" => "icon-half",
  "iconremove" => "icon-remove",
  "iconright" => "icon-right",
  "iconselected" => "icon-selected",
  "imageclass" => "img-class",
  "imagestyle" => "img-style",
  "indeterminateicon" => "indeterminate-icon",
  "indeterminatevalue" => "indeterminate-value",
  "indicatorcolor" => "indicator-color",
  "inlineactions" => "inline-actions",
  "inlinelabel" => "inline-label",
  "inputclass" => "input-class",
  "inputdebounce" => "input-debounce",
  "inputstyle" => "input-style",
  "insetlevel" => "inset-level",
  "itemaligned" => "item-aligned",
  "keepalive" => "keep-alive",
  "keepaliveexclude" => "keep-alive-exclude",
  "keepaliveinclude" => "keep-alive-include",
  "keepcolor" => "keep-color",
  "labelalways" => "label-always",
  "labelcolor" => "label-color",
  "labellines" => "label-lines",
  "labelslot" => "label-slot",
  "labelvalue" => "label-value",
  "labelcolorleft" => "left-label-color",
  "labelcolorright" => "right-label-color",
  "labelvalueleft" => "left-label-value",
  "labelvalueright" => "right-label-value",
  "labeltextcolor" => "label-text-color",
  "labeltextcolorleft" => "left-label-text-color",
  "labeltextcolorright" => "right-label-text-color",
  "lazyrules" => "lazy-rules",
  "lefticon" => "left-icon",
  "leftlabel" => "left-label",
  "manualfocus" => "manual-focus",
  "mapoptions" => "map-options",
  "markerlabels" => "marker-labels",
  "maxfiles" => "max-files",
  "maxfilesize" => "max-file-size",
  "maxheight" => "max-height",
  "maxvalues" => "max-values",
  "maxwidth" => "max-width",
  "maxtotalsize" => "max-total-size",
  "menuanchor" => "menu-anchor",
  "menuoffset" => "menu-offset",
  "menuself" => "menu-self",
  "menushrink" => "menu-shrink",
  "minheight" => "min-height",
  "mobilearrows" => "mobile-arrows",
  "multiline" => "multi-line",
  "narrowindicator" => "narrow-indicator",
  "nativecontextmenu" => "native-context-menu",
  "navmaxyearmonth" => "navigation-max-year-month",
  "navminyearmonth" => "navigation-min-year-month",
  "newvaluemode" => "new-value-mode",
  "nobackdrop" => "no-backdrop-dismiss",
  "nocaps" => "no-caps",
  "nodefaultspinner" => "no-default-spinner",
  "nodimming" => "no-dimming",
  "noerrorfocus" => "no-error-focus",
  "noerroricon" => "no-error-icon",
  "noesc" => "no-esc-dismiss",
  "nofocus" => "no-focus",
  "no-icon-animation" => "no-icon-animation",
  "noparentevent" => "no-parent-event",
  "norefocus" => "no-refocus",
  "noreset" => "no-reset",
  "noresetfocus" => "no-reset-focus",
  "noroutefullscreenexit" => "no-route-fullscreen-exit",
  "nothumbnails" => "no-thumbnails",
  "nowbtn" => "now-btn",
  "nowrap" => "no-wrap",
  "nounset" => "no-unset",
  "optiondisable" => "option-disable",
  "optionlabel" => "option-label",
  "optionscover" => "options-cover",
  "optionsdark" => "options-dark",
  "optionsdense" => "options-dense",
  "optionshour" => "hour-options",
  "optionsminute" => "minute-options",
  "optionssanitize" => "options-sanitize",
  "optionssecond" => "second-options",
  "optionsselectedclass" => "options-selected-class",
  "optionvalue" => "option-value",
  "outsidearrows" => "outside-arrows",
  "pagination" => ":pagination.sync",
  "paragraphtag" => "paragraph-tag",
  "placeholdersrc" => "placeholder-src",
  "popupcontentclass" => "popup-content-class",
  "popupcontentstyle" => "popup-content-style",
  "reactiverules" => "reactive-rules",
  "reversefillmask" => "reverse-fill-mask",
  "righticon" => "right-icon",
  "rules" => ":rules",
  "selected" => ":selected.sync",
  "sendraw" => "send-raw",
  "separatorclass" => "separator-class",
  "separatorstyle" => "separator-style",
  "scrolltarget" => "scroll-target",
  "shadowtext" => "shadow-text",
  "showifabove" => "show-if-above",
  "spinnercolor" => "spinner-color",
  "spinnersize" => "spinner-size",
  "stacked" => "stack",
  "stacklabel" => "stack-label",
  "switchindicator" => "switch-indicator",
  "switchtoggleside" => "switch-toggle-side",
  "textcolor" => "text-color",
  "thumbpath" => "thumb-path",
  "todaybtn" => "today-btn",
  "toggleindeterminate" => "toggle-indeterminate",
  "toggleorder" => "toggle-order",
  "toolbaroutline" => "toolbar-outline",
  "toolbarpush" => "toolbar-push",
  "toolbarrounded" => "toolbar-rounded",
  "toolbar" => ":toolbar",
  "toolbartextcolor" => "toolbar-text-color",
  "toolbartogglecolor" => "toolbar-toggle-color",
  "toolbarbg" => "toolbar-bg",
  "pastenative" => "@paste.native",
  "tablecolspan" => "table-colspan",
  "transitionhide" => "transition-hide",
  "transitionnext" => "transition-next",
  "transitionprev" => "transition-prev",
  "transitionshow" => "transition-show",
  "truevalue" => "true-value",
  "uncheckedicon" => "unchecked-icon",
  "unmaskedvalue" => "unmasked-value",
  "usechips" => "use-chips",
  "useinput" => "use-input",
  "vclosepopup" => "v-close-popup",
  "virtualscrollhorizontal" => "virtual-scroll-horizontal",
  "virtualscrollitemsize" => "virtual-scroll-item-size",
  "virtualscrollsliceratioafter" => "virtual-scroll-slice-ratio-after",
  "virtualscrollsliceratiobefore" => "virtual-scroll-slice-ratio-before",
  "virtualscrollslicesize" => "virtual-scroll-slice-size",
  "virtualscrollstickysizestart" => "virtual-scroll-sticky-size-start",
  "virtualscrollstickysizeend" => "virtual-scroll-sticky-size-end",
  "vripple" => "v-ripple",
  "withcredentials" => "with-credentials",
  "withseconds" => "with-seconds",
  "yearsinmonthview" => "years-in-month-view"
);

function kw(kwargs::Union{Vector{X}, Base.Iterators.Pairs, Dict},
  attributesmappings::Dict{String,String} = Dict{String,String}();
  merge::Bool = true) where X

  Stipple.attributes(kwargs, merge ? ( isempty(attributesmappings) ? ATTRIBUTES_MAPPINGS : Base.merge(ATTRIBUTES_MAPPINGS, attributesmappings) ) : attributesmappings)
end

macro kw(kwargs)
  :( Stipple.attributes($(esc(kwargs)), ATTRIBUTES_MAPPINGS) )
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
              attributesmappings::Dict{String, String} = Dict{String, String}(),
              mergemappings = true,
              kwargs...)
  q__elem(elem, args...; kw(kwargs, attributesmappings, merge = mergemappings)...)
end

function quasar(elem::Symbol, args...; kwargs...)
  xelem(Symbol("q-$elem"), args...; kwargs...)
end

function vue(elem::Symbol, args...; kwargs...)
  xelem(Symbol("q-$elem"), args...; kwargs...)
end

xelem_pure(elem::Symbol, args...; kwargs...) = xelem(elem, args...; kwargs...)
quasar_pure(elem::Symbol, args...; kwargs...) = quasar(elem, args...; kwargs...)
vue_pure(elem::Symbol, args...; kwargs...) = vue(elem, args...; kwargs...)

"""
    `csscolors(name, color)`
    `csscolors(names, colors)`
    `csscolors(prefix, colors)`

Construct a css string that defines colors to be used for styling quasar elements;
either as a value for the keyword argument `color` or as a classname with
the resective prefix `text-` or `bg-`.
(cf. [quasar docs](https://quasar.dev/style/color-palette))
# Usage
css = style(csscolors(:stipple, [RGB(0.2, 0.4, 0.8), "#123456", RGBA(0.1, 0.2, 0.3, 0.5)]))

ui(model) = css * page(model, class="container, text-stipple-1", [
  btn("Hit me", @click(:pressed), color="stipple-3")
])
"""
function csscolors(name, color::AbstractString)
  ".text-$name { color: $color !important}\n.bg-$name   { background: $color !important}"
end

csscolors(name, color::Colorant) = csscolors(name, "#" * hex(color, :auto))

csscolors(names::Vector, colors::Vector) = join([csscolors(n, c) for (n, c) in zip(names, colors)], "\n")

csscolors(prefix::Union{Symbol, AbstractString}, colors::Vector) = csscolors("$prefix-" .* string.(1:length(colors)), colors)

function __init__() :: Nothing
  Stipple.rendering_mappings(ATTRIBUTES_MAPPINGS)

  nothing
end

end
