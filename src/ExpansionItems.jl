module ExpansionItems

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export expansionitem

register_normal_element("q__expansion__item", context = @__MODULE__)


"""
    expansionitem(args...; kwargs...)

The `expansionitem` component allows the hiding of content that is not immediately relevant to the user. Think of them as accordion elements that expand when clicked on. It’s also known as a collapsible.

They are basically `item` components wrapped with additional functionality. So they can be included in `list` and inherit `item` component properties.

# Examples
----------

### Model

```julia-repl
julia> @vars ExpansionModel begin
          dummy::R{Bool} = true
       end
```

### View
```julia-repl
julia> list(bordered=true, class="rounded-borders", [
          expansionitem(expandseparator=true, icon="perm_identity", label="Account settings", caption="John Doe", [
            card([
              cardsection("Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quidem, eius reprehenderit eos corrupti
              commodi magni quaerat ex numquam, dolorum officiis modi facere maiores architecto suscipit iste
              eveniet doloribus ullam aliquid.")
            ])
          ]),
          expansionitem(expandseparator=true, icon="signal_wifi_off", label="Wifi settings", [
            card([
              cardsection("Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quidem, eius reprehenderit eos corrupti
              commodi magni quaerat ex numquam, dolorum officiis modi facere maiores architecto suscipit iste
              eveniet doloribus ullam aliquid.")
            ])
          ]),
          expansionitem(expandseparator=true, icon="drafts", label="Drafts", [
            card([
              cardsection("Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quidem, eius reprehenderit eos corrupti
              commodi magni quaerat ex numquam, dolorum officiis modi facere maiores architecto suscipit iste
              eveniet doloribus ullam aliquid.")
            ])
          ])
       ])
```

----------
# Arguments
----------

1. Behaviour
      * `duration::Int` - Animation duration (in milliseconds) ex. `:duration="1000"`
      * `default-opened::Bool` - Puts expansion item into open state on initial render; Overridden by ReactiveModel if used
      * `expandicontoggle::Bool` - Applies the expansion events to the expand icon only and not to the whole header
      * `group::String` - Register expansion item into a group (unique name that must be applied to all expansion items in that group) for coordinated open/close state within the group a.k.a. 'accordion mode' eg. `my-emails`
      * `popup::Bool` - Put expansion list into 'popup' mode
2. Content
      * `icon::String` - Icon name following Quasar convention; Make sure you have the icon library installed unless you are using 'img:' prefix; If 'none' (String) is used as value then no icon is rendered (but screen real estate will still be used for it) ex. `map` `ion-add` `img:https://cdn.quasar.dev/logo/svg/quasar-logo.svg` `img:path/to/some_image.png`
      * `expandicon::String` - Icon name following Quasar convention; Make sure you have the icon library installed unless you are using 'img:' prefix; If 'none' (String) is used as value then no icon is rendered (but screen real estate will still be used for it) ex. `map` `ion-add` `img:https://cdn.quasar.dev/logo/svg/quasar-logo.svg` `img:path/to/some_image.png`
      * `expandedicon::String` - Expand icon name (following Quasar convention) for when `expansionitem` is expanded; When used, it also disables the rotation animation of the expand icon; Make sure you have the icon library installed unless you are using 'img:' prefix ex. `map` `ion-add` `img:https://cdn.quasar.dev/logo/svg/quasar-logo.svg` `img:path/to/some_image.png`
      * `label::Union{String,Symbol}` - Header label
      * `labellines::Union{Int, String}` - Apply ellipsis when there's not enough space to render on the specified number of lines; If more than one line specified, then it will only work on webkit browsers because it uses the '-webkit-line-clamp' CSS property! ex. `labellines="2"` `1` `2`
      * `caption::String` - Header sub-label (unless using 'header' slot) ex. `Unread message: 5`
      * `captionlines::Union{Int, String}` - Apply ellipsis when there's not enough space to render on the specified number of lines; If more than one line specified, then it will only work on webkit browsers because it uses the '-webkit-line-clamp' CSS property! ex. `labellines="2"` `1` `2`
      * `headerinsetlevel::Int` - Apply an inset to header (unless using 'header' slot); Useful when header avatar/left side is missing but you want to align content with other items that do have a left side, or when you're building a menu ex. `headerinsetlevel="1"`
      * `contentinsetlevel::Int` - Apply an inset to content (changes content padding) ex. `contentinsetlevel="1"`
      * `expandseparator::Bool` - Add a separator between header and content
      * `switchtoggleside::Bool` - Switch expand icon side (from default 'right' to 'left')
      * `group::String` - Register expansion item into a group (unique name that must be applied to all expansion items in that group) for coordinated open/close state within the group a.k.a. 'accordion mode' ex. `my-emails`
4. State
      * `disable::Bool` - Put component in disabled mode
5. Style
      * `expand-icon-class::Union{Vector, String, Dict}` - Apply custom class(es) to the expand icon item section ex. `text-purple`
      * `dark::Bool` - Notify the component that the background is a dark color
      * `dense::Bool` - Dense mode; occupies less space
      * `densetoggle::Bool` - Use dense mode for expand icon
      * `headerstyle::Union{Vector, String, Dict}` - Apply custom style(s) to the header section ex. `background: '#ff0000'` `headerstyle=opts( backgroundColor: "#ff0000" )`
"""
function expansionitem(args...; kwargs...)
  q__expansion__item(args...; kw(kwargs)...)
end

end
