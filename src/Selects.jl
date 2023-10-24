module Selects

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, select, template, register_normal_element

register_normal_element("q__select", context = @__MODULE__)

"""
    select(fieldname::Symbol, args...; options::Symbol, kwargs...)



----------
# Examples
----------

### Model

```julia-repl
julia> @vars SelectModel begin
          model::R{Vector{String}} = []
          networks::R{Vector{String}} = ["Google", "Facebook", "Twitter", "Pinterest", "Reddit"]
       end
```

### View
```julia-repl
julia> select(:model, options= :networks, useinput=true, multiple=true, clearable = true, filled = true, counter = true, usechips = true, label="Social Networks")
```

----------
# Arguments
----------

1. Behaviour
      * `name::String` - Used to specify the name of the control; Useful if dealing with forms; If not specified, it takes the value of 'for' prop, if it exists ex. `car-id` `car-id`
      * `virtualscrollhorizontal::Bool` - Make virtual list work in horizontal mode
      * `error::Bool` - Does field have validation errors?
      * `rules::Vector` - Array of Functions/Strings; If String, then it must be a name of one of the embedded validation rules  `rules="[ val => val.length <= 3 || 'Please use maximum 3 characters' ]"`
      * `reactiverules::Bool` - By default a change in the rules does not trigger a new validation until the model changes; If set to true then a change in the rules will trigger a validation; Has a performance penalty, so use it only when you really need it
      * `lazyrules::Union{Bool, String}` - If set to boolean true then it checks validation status against the 'rules' only after field loses focus for first time; If set to 'ondemand' then it will trigger only when component's validate() method is manually called or when the wrapper `form` submits itself ex. `(Boolean) true` `(Boolean) false` `ondemand`
      * `loading::Bool` - Signals the user a process is in progress by displaying a spinner; Spinner can be customized by using the 'loading' slot.
      * `clearable::Bool` - Appends clearable icon when a value (not undefined or null) is set; When clicked, model becomes null
      * `autofocus::Bool` - Focus field on initial component render
      * `for::String` - Used to specify the 'id' of the control and also the 'for' attribute of the label that wraps it; If no 'name' prop is specified, then it is used for this attribute as well `myFieldsId`
      * `hidedropdownicon::Bool` - Hide dropdown icon
      * `fillinput::Bool` - Fills the input with current value; Useful along with 'hideselected'; Does NOT works along with 'multiple' selection
      * `newvaluemode::String` - Enables creation of new values and defines behavior when a new value is added: 'add' means it adds the value (even if possible duplicate), 'add-unique' adds only unique values, and 'toggle' adds or removes the value (based on if it exists or not already); When using this prop then listening for `newvalue` becomes optional (only to override the behavior defined by `newvaluemode`)  ex. `add` `add-unique` `toggle`
      * `autocomplete::String` - Autocomplete attribute for field ex. `autocomplete="country"`
      * `transitionshow::String` - Transition when showing the menu/dialog; One of [embedded transitions](https://v1.quasar.dev/options/transitions) ex. `fade` `slide-down`
      * `transitionhide::String` - Transition when hiding the menu/dialog; One of [embedded transitions](https://v1.quasar.dev/options/transitions) ex. `fade` `slide-down`
      * `behavior::String` - Overrides the default dynamic mode of showing as menu on desktop and dialog on mobiles `default` `menu` `dialog`
2. Content
      * `tablecolspan::Union{Int, String}` - The number of columns in the table (you need this if you use table-layout: fixed) ex. `tablecolspan="12"`
      * `errormessage::String` - Validation error message (gets displayed only if 'error' is set to 'true') ex. `Username must have at least 5 characters`
      * `noerroricon::Bool` - Hide error icon when there is an error
      * `label::Union{String,Symbol}` - A text label that will “float” up above the input field, once the field gets focus ex. `Username`
      * `stacklabel::Bool` - Label will be always shown above the field regardless of field content (if any)
      * `hint::String` - Helper (hint) text which gets placed below your wrapped form component ex. `Fill in between 3 and 12 characters`
      * `hidehint::Bool` - Hide the helper (hint) text when field doesn't have focus
      * `prefix::String` - Prefix ex. `\$`
      * `suffix::String` - Suffix ex. `@gmail.com`
      * `loading::Bool` - Signals the user a process is in progress by displaying a spinner; Spinner can be customized by using the 'loading' slot.
      * `clearable::Bool` - Appends clearable icon when a value (not undefined or null) is set; When clicked, model becomes null
      * `clearicon::String` - Custom icon to use for the clear button when using along with 'clearable' attribute ex. `close`
      * `labelslot::Bool` - Enables label slot; You need to set it to force use of the 'label' slot if the 'label' prop is not set
      * `bottomslots::Bool` - Enables bottom slots ('error', 'hint', 'counter')
      * `counter::Bool` - Show an automatic counter on bottom right
      * `dropdownicon::String` - Icon name; ; Make sure you have the icon library installed unless you are using 'img:' prefix; If 'none' (String) is used as value then no icon is rendered (but screen real estate will still be used for it) ex. `map` `ion-add` `img=https://cdn.quasar.dev/logo/svg/quasar-logo.svg` `img=path/to/some_image.png`
      * `useinput::Bool` - Use an input tag where users can type
      * `inputdebounce::Union{Int, String}` - Debounce the input model update with an amount of milliseconds ex. `500` `600`
3. General
      * `tabindex::Union{Int, String}` - Tabindex HTML attribute value ex. `0` `100`
4. Model
      * `multiple::Bool` - Allow multiple selection; Model must be Array
      * `emitvalue::Bool` - Update model with the value of the selected option instead of the whole option
5. Options
      * `options::Vector` - Available options that the user can select from. For best performance freeze the list of options ex. `options=[ 'BMW', 'Samsung Phone' ]`
      * `optionvalue::String` - Property of option which holds the 'value'; If using a function then for best performance, reference it from your scope and do not define it inline ex. `optionvalue=modelNumber` `optionvalue="(item) => item === null ? null : item.modelNumber"`
      * `optionlabel::Union{String,Symbol}` - Property of option which holds the 'label'; If using a function then for best performance, reference it from your scope and do not define it inline ex. `optionlabel=itemName` `optionlabel="(item) => item === null ? null : item.itemName"`
      * `optiondisable::String` - Property of option which tells it's disabled; The value of the property must be a Boolean; If using a function then for best performance, reference it from your scope and do not define it inline ex. `optiondisable=cannotSelect` `optiondisable="(item) => item === null ? null : item.cannotSelect"`
      * `optionsdense::Bool` - Dense mode for options list; occupies less space
      * `optionsdark::Bool` - Options menu will be colored with a dark color
      * `optionsselectedclass::String` - CSS class name for options that are active/selected; Set it to an empty string to stop applying the default (which is text-* where * is the 'color' prop value) ex. `text-orange`
      * `optionssanitize::Bool` - Force use of textContent instead of innerHTML to render options; Use it when the options might be unsafe (from user input); Does NOT apply when using 'option' slot!
      * `optionscover::Bool` - Expanded menu will cover the component (will not work along with `useinput` attribute for obvious reasons)
      * `menushrink::Bool` - Allow the options list to be narrower than the field (only in menu mode)
      * `mapoptions::Bool` - Try to map labels of model from `options` Vector; has a small performance penalty; If you are using emit-value you will probably need to use map-options to display the label text in the select field rather than the value; Refer to the 'Affecting model' section above
6. Position
      * `menuanchor::String` - Two values setting the starting position or anchor point of the options list relative to the field (only in menu mode) ex. `top left` `top middle` `top right` `top start` `top end` `center left` `center middle` `center right` `center start` `center end` `bottom left` `bottom middle` `bottom right` `bottom start` `bottom end`
      * `menuself::String` - Two values setting the options list's own position relative to its target (only in menu mode) ex. `top left` etc
      * `menuoffset::Vector` - An array of two numbers to offset the options list horizontally and vertically in pixels (only in menu mode) ex. `[8, 8]`
7. Selection
      * `multiple::Bool` - Allow multiple selection; Model must be Array
      * `displayvalue::Union{Int, String}` - Override default selection string, if not using `selected` slot/scoped slot and if not using `usechips` attribute
      * `displayvaluesanitize::Bool` - Force use of textContent instead of innerHTML to render selected option(s); Use it when the selected option(s) might be unsafe (from user input); Does NOT apply when using `selected` or `selecteditem` slots!
      * `hideselected::Bool` - Hides selection; Use the underlying input tag to hold the label (instead of showing it to the right of the input) of the selected option; Only works for non `multiple` Selects
      * `maxvalues::Union{Int, String}` - Allow a maximum number of selections that the user can do ex. `5`
      * `usechips::Bool` - Use `chip` component to show what is currently selected
8. State
      * `disable::Bool` - Put component in disabled mode
      * `readonly::Bool` - Put component in readonly mode
9. Style
      * `labelcolor::String` - Color name for the label from the [Color Palette](https://quasar.dev/style/color-palette); Overrides the `color` prop; The difference from `color` prop is that the label will always have this color, even when field is not focused ex. `primary` `teal-10`
      * `color::String` - Color name for component from the [Color Palette](https://quasar.dev/style/color-palette)
      * `bgcolor::String` - Background color name for component from the [Color Palette](https://quasar.dev/style/color-palette)
      * `dark::Bool` - Notify the component that the background is a dark color
      * `filled::Bool` - Use `filled` design for the field
      * `outlined::Bool` - Use `outlined` design for the field
      * `borderless::Bool` - Use `borderless` design for the field
      * `standout::Union{Bool, String}` - Use 'standout' design for the field; Specifies classes to be applied when focused (overriding default ones) ex. `standout` `standout="bg-primary text-white"`
      * `hidebottomspace::Bool` - Do not reserve space for hint/error/counter anymore when these are not used; As a result, it also disables the animation for those; It also allows the hint/error area to stretch vertically based on its content
      * `rounded::Bool` - Applies a small standard border-radius for a squared shape of the component
      * `square::Bool` - Remove border-radius so borders are squared; Overrides `rounded` prop/attribute
      * `dense::Bool` - Dense mode; occupies less space
      * `itemaligned::Bool` - Match inner content alignment to that of `item` component
      * `popupcontentclass::String` - Class definitions to be attributed to the popup content ex. `my-special-class`
      * `popupcontentstyle::Union{Vector, String, Dict}` - Style definitions to be attributed to the popup content ex. `background-color: #ff0000` `popupcontentstyle!="{ backgroundColor: '#ff0000' }"`
      * `inputclass::Union{Vector, String, Dict}` - Class definitions to be attributed to the underlying input tag ex. `my-special-class` `inputclass!="{ 'my-special-class': <condition> }"`
      * `inputstyle::Union{Vector, String, Dict}` - Style definitions to be attributed to the underlying input tag ex. `background-color: #ff0000` `inputstyle!="{ backgroundColor: '#ff0000' }"`
10. Virtual-scroll
      * `virtualscrollslicesize::Union{Int, String}` - Minimum number of items to render in the virtual list ex. `virtualscrollslicesize="60"` `30`
      * `virtualscrollsliceratiobefore::Union{Int, String}` - Ratio of number of items in visible zone to render before it ex. `virtualscrollsliceratiobefore="30"` `30`
      * `virtualscrollsliceratioafter::Union{Int, String}` - Ratio of number of items in visible zone to render after it ex. `virtualscrollsliceratioafter="0.3"`
      * `virtualscrollitemsize::Union{Int, String}` - Default size in pixels (height if vertical, width if horizontal) of an item; This value is used for rendering the initial list; Try to use a value close to the minimum size of an item  ex. `virtualscrollitemsize="48"`
      * `virtualscrollstickysizestart::Union{Int, String}` - Size in pixels (height if vertical, width if horizontal) of the sticky part (if using one) at the start of the list; A correct value will improve scroll precision ex. `0` `virtualscrollstickysizestart="23`
      * `virtualscrollstickysizeend::Union{Int, String}` - Size in pixels (height if vertical, width if horizontal) of the sticky part (if using one) at the end of the list; A correct value will improve scroll precision ex. `0`
      * `tablecolspan::Union{Int, String}` - The number of columns in the table (you need this if you use table-layout: fixed) ex. `tablecolspan="3"`
"""
function select(fieldname::Symbol,
                args...;
                options::Union{Symbol, Vector},
                kwargs...)

  q__select(args...; kw(
    [Symbol(":options") => options, :fieldname => fieldname, kwargs...])...)
end

end
