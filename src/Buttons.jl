module Buttons

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export btn, btngroup, btndropdown, Btn, btntoggle

register_normal_element("q__btn", context = @__MODULE__)
register_normal_element("q__btn__group", context = @__MODULE__)
register_normal_element("q__btn__dropdown", context = @__MODULE__)
register_normal_element("q__btn__toggle", context = @__MODULE__)

"""
Stipple has a component called `btn` which is a button with a few extra useful features. For instance, it comes in two shapes: rectangle (default) and round. It also has the material ripple effect baked in (which can be disabled).

The button component also comes with a spinner or loading effect. You would use this for times when app execution may cause a delay and you want to give the user some feedback about that delay. When used, the button will display a spinning animation as soon as the user clicks the button.

When not disabled or spinning, `btn` emits a `@click` event, as soon as it is clicked or tapped.

# Examples
```
julia> btn("Move Left", color = "primary", icon = "mail", @click("press_btn = true"))

julia> btn("Go to Hello World", color = "red", type = "a", href = "hello", icon = "map", iconright = "send")

julia> btn("Connect to server!", color="green", textcolor="black", @click("btnConnect=!btnConnect"), [
          tooltip(contentclass="bg-indigo", contentstyle="font-size: 16px", 
          style="offset: 10px 10px",  "Ports bounded to sockets!")]
       )       
```

-----------
# Arguments
-----------

1. Behavior
      * `loading::Bool` - Put button into loading state (displays a `spinner` -- can be overridden by using a 'loading' slot)
      * `percentage::Union{Int, Float64}` - Percentage (0.0 < x < 100.0); To be used along 'loading' prop; Display a progress bar on the background ex. `23`
      * `darkpercentage::Bool` - Progress bar on the background should have dark color; To be used along with 'percentage' and 'loading' props
2. Content
      * `label::Union{String, Int}` - The text that will be shown on the button ex. `Button Label`
      * `icon::String` - Icon name following Quasar convention; Make sure you have the icon library installed unless you are using 'img:' prefix; If 'none' (String) is used as value then no icon is rendered (but screen real estate will still be used for it) ex. `map` `ion-add` `img:https://cdn.quasar.dev/logo/svg/quasar-logo.svg` `img:path/to/some_image.png`
      * `iconright::String` - Icon name following Quasar convention; Make sure you have the icon library installed unless you are using 'img:' prefix; If 'none' (String) is used as value then no icon is rendered (but screen real estate will still be used for it) ex. `map` `ion-add` `img:https://cdn.quasar.dev/logo/svg/quasar-logo.svg` `img:path/to/some_image.png`
      * `nocaps::Bool` - Avoid turning label text into caps (which happens by default)
      * `nowrap::Bool` - Avoid label text wrapping
      * `align::String` - Label or content alignment default. `center` accepted values. `left` `right` `center` `around` `between` `evenly`
      * `stack::Bool` - Stack icon and label vertically instead of on same line (like it is by default)
      * `stretch::Bool` - When used on flexbox parent, button will stretch to parent's height
3. General
      * `type::String` - 1) Define the button native type attribute (submit, reset, button) or 2) render component with <a> tag so you can access events even if disable or 3) Use 'href' prop and specify 'type' as a media tag default. `button` ex. `a` `submit` `reset` `button` `image/png` `href="https://some-site.net" target="_blank"`
      * `tabindex::Union{Int, String}` - Tabindex HTML attribute value
4. Navigation
      * `href::String` - Native <a> link href attribute; Has priority over the 'to' and 'replace' props ex. `https://quasar.dev` `href="https://quasar.dev" target="_blank"`
      * `target::String` - Native <a> link target attribute; Use it only with 'to' or 'href' props ex. `_blank` `_self` `_parent` `_top`
5. State
      * `loading::Bool` - Put button into loading state (displays a `spinner` -- can be overridden by using a 'loading' slot)
      * `disable::Bool` - Put component in disabled mode
6. Style
      * `size::String` - Size in CSS units, including unit name or standard size name (xs|sm|md|lg|xl) ex. `16px` `2rem` `xs` `md`
      * `ripple::Union{Bool, Dict}` - Configure material ripple (disable it by setting it to 'false' or supply a config object) default. `true` ex. `false` `{ "early" => true, "center" => true, "color" => "teal", "keyCodes" => [] }`
      * `outline::Bool` - Use `outline` design
      * `flat::Bool` - Use `flat` design
      * `unelevated::Bool` - Remove shadow
      * `rounded::Bool` - Applies a more prominent border-radius for a squared shape button
      * `push::Bool` - Use 'push' design
      * `glossy::Bool` - Applies a glossy effect
      * `fab::Bool` - Makes button size and shape to fit a Floating Action Button
      * `fabmini::Bool` - Makes button size and shape to fit a small Floating Action Button
      * `padding::String` - Apply custom padding (vertical [horizontal]); Size in CSS units, including unit name or standard size name (none|xs|sm|md|lg|xl); Also removes the min width and height when set
      * `color::String` - Color name for component from the [Color Palette](https://quasar.dev/style/color-palette) eg. `primary` `teal-10`
      * `textcolor::String` - Overrides text color (if needed); Color name from the [Color Palette](https://quasar.dev/style/color-palette) eg. `primary` `teal-10`
      * `dense::Bool` - Dense mode; occupies less space
      * `round::Bool` - Makes a circle shaped button

"""
function btn( label::Union{String,Symbol} = "",
              args...;
              content::Union{String,Vector,Function} = "",
              kwargs...)
  q__btn([isa(content, Function) ? content() : join(content)],
          args...;
          kw([:label => label, kwargs...])...
  )
end

function btn( content::Union{Function,Vector},
              label::Union{String,Symbol} = "",
              args...;
              kwargs...)
  btn(label, args...; content = content, kwargs...)
end

function btn( args...;
              label::Union{String,Symbol} = "",
              content::Union{String,Vector,Function} = "",
              kwargs...)
  btn(label, args...; content = content, kwargs...)
end


mutable struct Btn
  label
  args
  wrap
  content
  kwargs

  Btn(label::Union{String,Symbol} = "",
      args...;
      content::Union{String,Vector,Function} = "",
      kwargs...) = new(fieldname, args, mask, kwargs)
end

Base.string(bt::Btn) = btn(bt.label, bt.args...; bt.content, bt.kwargs...)

"""
You can conveniently group `btn` and `btndropdown` using `btngroup`. Be sure to check those component’s respective pages to see their props and methods.

-----------
# Arguments
-----------

1. Content
      * `spread::Bool` - Spread horizontally to all available space
      * `stretch::Bool` - When used on flexbox parent, buttons will stretch to parent's height
2. Style
      * `outline::Bool` - Use 'outline' design for buttons
      * `flat::Bool` - Use 'flat' design for buttons
      * `unelevated::Bool` - Remove shadow from buttons
      * `rounded::Bool` - Applies a more prominent border-radius for squared shape buttons
      * `push::Bool` - Use 'push' design for buttons
      * `glossy::Bool` - Applies a glossy effect
"""
function btngroup(args...; kwargs...)
  q__btn__group(args...; kw(kwargs)...)
end

"""
`btndropdown` is a very convenient dropdown button. Goes very well with `list` as dropdown content, but it’s by no means limited to it.

In case you are looking for a dropdown “input” instead of “button” use Select instead.

# Examples

```
julia> btndropdown(label = "Dropdown Button", color = "primary", [
            list([
              item("Spain", clickable = true, vclosepopup = true, @click("first_item = true")),
              item("USA", clickable = true, vclosepopup = true, @click("second_item = true")),
              item("Netherlands", clickable = true, vclosepopup = true, @click("third_item = true"))
            ]),
       ])
```

-----------
# Arguments
-----------

1. Behavior
      * `loading::Bool` - Put button into loading state (displays a `spinner` -- can be overridden by using a 'loading' slot)
      * `split::Bool` - Split dropdown icon into its own button
      * `disablemainbtn::Bool` - Disable main button (useful along with 'split' prop)
      * `disabledropdown::Bool` - Disables dropdown (dropdown button if using along 'split' prop)
      * `persistent::Bool` - Allows the menu to not be dismissed by a click/tap outside of the menu or by hitting the ESC key
      * `autoclose::Bool` - Allows any click/tap in the menu to close it; Useful instead of attaching events to each menu item that should close the menu on click/tap
2. Content
      * `label::Union{String, Int}` - The text that will be shown on the button ex. `"Button Label"`
      * `icon::String` - Icon name following Quasar convention; Make sure you have the icon library installed unless you are using 'img:' prefix; If 'none' (String) is used as value then no icon is rendered (but screen real estate will still be used for it) ex. `"map"` `"ion-add"` `"img:https://cdn.quasar.dev/logo/svg/quasar-logo.svg"` `"img:path/to/some_image.png"`
      * `iconright::String` - Icon name following Quasar convention; Make sure you have the icon library installed unless you are using 'img:' prefix; If 'none' (String) is used as value then no icon is rendered (but screen real estate will still be used for it) ex. `"map"` `"ion-add"` `"img:https://cdn.quasar.dev/logo/svg/quasar-logo.svg"` `"img:path/to/some_image.png"`
      * `nocaps::Bool` - Avoid turning label text into caps (which happens by default)
      * `nowrap::Bool` - Avoid label text wrapping
      * `align::String`  - Label or content alignment default. `center` ex. `"left"` `"right"` `"center"` `"around"` `"between"` `"evenly"`
      * `stack::Bool` - Stack icon and label vertically instead of on same line (like it is by default)
      * `stretch::Bool` - When used on flexbox parent, button will stretch to parent's height
      * `split::Bool` - Split dropdown icon into its own button
      * `dropdownicon::String` - Icon name following Quasar convention; Make sure you have the icon library installed unless you are using 'img:' prefix; If 'none' (String) is used as value then no icon is rendered (but screen real estate will still be used for it) ex. `"map"` `"ion-add"` `"img:https://cdn.quasar.dev/logo/svg/quasar-logo.svg"` `"img:path/to/some_image.png"`
3. General
      * `type::String` - 1) Define the button native type attribute (submit, reset, button) or 2) render component with <a> tag so you can access events even if disable or 3) Use 'href' prop and specify 'type' as a media tag default. `"button"` ex. `"a"` `"submit"` `"reset"` `"button"` `"image/png"` `href="https://some-site.net" target="_blank"`
      * `tabindex::Union{Int, String}` - Tabindex HTML attribute value ex. `0` `100`
4. Navigation
      * `href::String` - Native <a> link href attribute; Has priority over the 'to' and 'replace' props ex. `"https://quasar.dev"` `href="https://quasar.dev" target="_blank"`
      * `target::String` - Native <a> link target attribute; Use it only with 'to' or 'href' props ex. `"_blank"` `"_self"` `"_parent"` `"_top"`
5. Position
      * `cover::Bool` - Allows the menu to cover the button. When used, the 'menu-self' and 'menu-fit' props are no longer effective
      * `menuanchor::String` - Two values setting the starting position or anchor point of the menu relative to its target default. `"bottom end"` ex. `"top start"` `"bottom start"` `"top end"` `"bottom end"` `"right start"` `"right end"` `"left start"` `"left end"`
      * `menuself::String` - Two values setting the menu's own position relative to its target default. `"top end"` ex. `"top start"` `"bottom start"` `"top end"` `"bottom end"` `"right start"` `"right end"` `"left start"` `"left end"`
      * `menuoffset::Vector` - An array of two numbers to offset the menu horizontally and vertically in pixels ex. `[8,8]` `[5,10]`
6. State
      * `loading::Bool` - Put button into loading state (displays a `spinner` -- can be overridden by using a 'loading' slot)
      * `disable::Bool` - Put compontent in disabled state
7. Style
      * `size::String` - Size in CSS units or percentage, ex. `"25px"` `"2.5em"` `"md"` `"xs"`
      * `ripple::Union{Bool, Dict}` - Configure material ripple (disable it by setting it to 'false' or supply a config object) default. `true` ex. `false` `{ "early" => true, "center" => true, "color" => "teal", "keyCodes" => []}`
      * `outline::Bool` - Use 'outline' design
      * `flat::Bool` - Use 'flat' design
      * `unelevated::Bool` - Remove shadow
      * `rounded::Bool` - Applies a more prominent border-radius for a squared shape button
      * `push::Bool` - Use 'push' design
      * `glossy::Bool` - Applies a glossy effect
      * `fab::Bool` - Makes button size and shape to fit a Floating Action Button
      * `fabmini::Bool` - Makes button size and shape to fit a Floating Action Button Mini
      * `padding::String` - Apply custom padding (vertical [horizontal]); Size in CSS units, including unit name or standard size name (none|xs|sm|md|lg|xl); Also removes the min width and height when set ex. `"16px"`,`"2rem"` ,`"xs"` ,`"md lg"` ,`"2px 2px 5px 7px"`
      * `color::String` - Color name for component from the [Quasar Color Palette](https://quasar.dev/options/color-palette) ex. `"primary"` `"teal-10"`
      * `textcolor::String` - Overrides text color (if needed); Color name from the [Quasar Color Palette](https://quasar.dev/options/color-palette) ex. `"white"` `"primary"` `"teal-10"`
      * `dense::Bool` - Dense mode; occupies less space
      * `noiconanimation::Bool` - Disables the rotation of the dropdown icon when state is toggled
      * `contentstyle::Union{Vector, String, Dict}` - Style definitions to be attributed to the menu ex. `{"background-color" => "#ff0000"}` `contentclass!="{ 'my-special-class': <condition> }"`
      * `contentclass::Union{Vector, String, Dict}` - Class definitions to be attributed to the menu ex. `"my-special-class"` `contentclass!="{ 'my-special-class': <condition> }"`
"""
function btndropdown(args...; kwargs...)
  q__btn__dropdown(args...; kw(kwargs)...)
end

"""
    btntoggle(fieldname::Symbol, args...; options::Symbol, kwargs...)



----------
# Examples
----------

### Model

```julia-repl
julia> @app begin
           @in network = :google
           @in networks = [Stipple.opts(label = x, value = Symbol(lowercase(x))) for x in ["Google", "Facebook", "Twitter", "Pinterest", "Reddit"]]
       end
```

### View
```julia-repl
julia> btntoggle(:network, options = :networks, label="Social Networks", rounded = true, color = "white", textcolor= "primary")
"<q-btn-toggle color=\\"white\\" rounded v-model=\\"network\\" label=\\"Social Networks\\" :options=\\"networks\\" text-color=\\"primary\\"></q-btn-toggle>"
```

----------
# Arguments
----------

1. Behaviour
      * `name::String` - Used to specify the name of the control; Useful if dealing with forms; If not specified, it takes the value of 'for' prop, if it exists ex. `car-id` `car-id`
2. Content
      * `tablecolspan::Union{Int, String}` - The number of columns in the table (you need this if you use table-layout: fixed) ex. `tablecolspan="12"`
      * `spread::Bool`- Spread horizontally to all available space
      * `no-caps::Bool`- Avoid turning label text into caps (which happens by default)
      * `no-wrap::Bool`- Avoid label text wrapping
      * `stack::Bool`- Stack icon and label vertically instead of on same line (like it is by default)
      * `stretch::Bool`- When used on flexbox parent, button will stretch to parent's height
3. Model
      * `options::Vector` - Available options that the user can select from. For best performance freeze the list of options ex. `options=[ 'BMW', 'Samsung Phone' ]`
      * `clearable::Bool` - Clears model on click of the already selected button
4. State
      * `disable::Bool` - Put component in disabled mode
      * `readonly::Bool` - Put component in readonly mode
5. Style
      * `color::String` - Color name for component from the Quasar Color Palette
      * `text-color::String` - Overrides text color (if needed); Color name from the Quasar Color Palette
      * `toggle-color::String` - Color name for component from the Quasar Color Palette
      * `toggle-text-color::String` - Overrides text color (if needed); Color name from the Quasar Color Palette
      * `outline::Boolean` - Use 'outline' design
      * `flat::Boolean` - Use 'flat' design
      * `unelevated::Boolean` - Remove shadow
      * `rounded::Boolean` - Applies a more prominent border-radius for a squared shape button
      * `push::Boolean` - Use 'push' design
      * `glossy::Boolean` - Applies a glossy effect
      * `size::String` - Button size name or a CSS unit including unit name
      * `padding::String` - Apply custom padding (vertical [horizontal]); Size in CSS units, including unit name or standard size name (none|xs|sm|md|lg|xl); Also removes the min width and height when set
      * `ripple::Union{Boolean, Dict}`` - Configure material ripple (disable it by setting it to 'false' or supply a Dict with `js_attr`, e.g. `js_attr(Stipple.opts(early = true, center = true, color = 'teal', keyCodes = []))`)
      * `dense::Boolean` - Dense mode; occupies less space
"""
function btntoggle(fieldname::Symbol,
                args...;
                options::Symbol,
                kwargs...)

  q__btn__toggle(args...; kw(
    [Symbol(":options") => options, :fieldname => fieldname, kwargs...])...)
end

end
