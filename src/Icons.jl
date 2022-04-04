module Icons

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export icon

register_normal_element("q__icon", context = @__MODULE__)

"""
    icon(name::Union{String,Symbol}, args...; content::Union{String,Vector,Function} = "", kwargs...)
 
Stipple supports out of the box: [Material Icons](https://fonts.google.com/icons?selected=Material+Icons) , [Font Awesome](https://fontawesome.com/icons), [Ionicons](https://ionic.io/ionicons), [MDI](https://materialdesignicons.com/), [Eva Icons](https://akveo.github.io/eva-icons/#/), [Themify Icons](https://themify.me/themify-icons), [Line Awesome](https://icons8.com/line-awesome) and [Bootstrap Icons](https://icons.getbootstrap.com/).

Furthermore you can [add support by yourself](https://v1.quasar.dev/vue-components/icon#custom-mapping) for any icon lib.

----------
# Examples
----------

### View

```julia-repl
julia> icon("font_download", class="text-primary", style="font-size: 32px;")
julia> icon("warning", class="text-red", style="font-size:4rem;")
julia> icon("format_size", style="color: #ccc; font-size: 1.4em;")
julia> icon("print", class="text-teal", style="font-size: 4.4em;")
julia> icon("today", class="text-orange", style="font-size: 2em;")
julia> icon("style", style="font-size: 3em;")
```

-----------
# Arguments
-----------

1. Content
      * `tag::String` - HTML tag to render, unless no icon is supplied or it's an svg icon ex. `div` `i`
      * `left::Bool` - Useful if icon is on the left side of something: applies a standard margin on the right side of Icon
      * `right::Bool` - Useful if icon is on the right side of something: applies a standard margin on the left side of Icon
2. Model
      * `name::String` - Icon name; Make sure you have the icon library installed unless you are using 'img:' prefix; If 'none' (String) is used as value then no icon is rendered (but screen real estate will still be used for it) ex. `map` `ion-add` `img:https://cdn.quasar.dev/logo/svg/quasar-logo.svg` `img:path/to/some_image.png`
3. Style
      * `size::String` - Size in CSS units, including unit name or standard size name `16px` `2rem` `xs` `md`
      * `color::String` - Color name for component from the [Color Palette](https://quasar.dev/style/color-palette) eg. `primary` `teal-10`
"""
function icon(name::Union{String,Symbol},
              args...;
              content::Union{String,Vector,Function} = "",
              kwargs...)

  q__icon([isa(content, Function) ? content() : join(content)], args...; kw([:name => name, kwargs...])...)
end

icon( content::Union{Vector,Function},
      args...;
      name::Union{Symbol,String} = "",
      kwargs...) = icon(name, args...; content, kwargs...)

end
