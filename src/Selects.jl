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
julia> @reactive mutable struct SelectModel <: ReactiveModel
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
      * `label::String` - A text label that will “float” up above the input field, once the field gets focus ex. `Username`
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
      * `optionvalue::Function | String`   # WIP -----------------------------
6. Position
      * `menu-anchor`
"""
function select(fieldname::Symbol,
                args...;
                options::Symbol,
                kwargs...)

  q__select(args...; kw(
    [Symbol(":options") => options, :fieldname => fieldname, kwargs...])...)
end

end
