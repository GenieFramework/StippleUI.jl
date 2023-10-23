module ButtonToggles

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template, register_normal_element

export buttontoggle

register_normal_element("q__btn__toggle", context = @__MODULE__)

"""
    buttontoggle(fieldname::Symbol, args...; options::Symbol, kwargs...)



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
julia> buttontoggle(:network, options = :networks, label="Social Networks", rounded = true, color = "white", textcolor= "primary")
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
function buttontoggle(fieldname::Symbol,
                args...;
                options::Symbol,
                kwargs...)

  q__btn__toggle(args...; kw(
    [Symbol(":options") => options, :fieldname => fieldname, kwargs...])...)
end

end
