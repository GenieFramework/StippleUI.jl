module Cards

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export card, card_section, card_actions
export cardsection, cardactions
export card_1

register_normal_element("q__card", context = @__MODULE__)
register_normal_element("q__card__section", context = @__MODULE__)
register_normal_element("q__card__actions", context = @__MODULE__)

"""
      card(args...; kwargs...)

`Card` component is a great way to display important pieces of grouped content. The `Card` component is intentionally lightweight and essentially a containing element that is capable of “hosting” any other component that is appropriate.

-----------
### Examples
-----------

### Model

```julia-repl
julia> @vars CardModel begin
          lorem::R{String} = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
          url::R{String} = "https://cdn.quasar.dev/img/parallax2.jpg"
       end
```

### View

```julia-repl
julia> card(class="my-card", [
          imageview(src=:url, no__transition=true, [
            Html.div("Title", class="absolute-bottom text-h6")
          ]),
          card_section("{{lorem}}")
       ])
```
-----------
### Arguments
-----------
1. Content
       * `tag::String` - HTML tag to render default `"div"` ex. `"div"` `"form"`
2. Style
       * `dark::Bool` - Notify the component that the background is a dark color
       * `square::Bool` - Removes border-radius so borders are squared
       * `flat::Bool` - Applies a 'flat' design (no default shadow)
       * `bordered::Bool` - Applies a default border to the component

"""
function card(args...; kwargs...)
  q__card(args...; kw(kwargs)...)
end

"""
      card_section(args...; kwargs...)
----------
### Examples
----------

### View

```julia-repl
julia> card(class="text-white", style="background: radial-gradient(circle, #35a2ff 0%, #014a88 100%); width: 30%", [
          card_section("lorLorem Ipsum is simply dummy text of the printing
          and typesetting industry")
       ])
```

-----------
### Arguments
-----------

* `tag::String` - HTML tag to render ex. `"div"`, `"form"`
* `horizontal::Bool` - Display a horizontal section (will have no padding and can contain other `card_section`)
"""
function card_section(args...; kwargs...)
  q__card__section(args...; kw(kwargs)...)
end

const cardsection = card_section

"""

----------
### Examples
----------
    card_actions()

### Model

```julia-repl
julia> @vars CardModel begin
          lorem::R{String} = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
       end
```

### View

```julia-repl
julia> card(class="my-card bg-secondary text-white", [
          card_section([
            Html.div("Our Changing Planet", class="text-h6"),
            Html.div("by John Doe", class="text-subtitle2")
          ]),
          card_section("{{ lorem }}"),
          card_actions([
            btn(flat=true, "Action 1"),
            btn(flat=true, "Action2")
          ])
        ])
```
-----------
### Arguments
-----------

* `align::String` - Specify how to align the actions ("left", "center", "right", "between", "around", "evenly", "stretch")
* `vertical:Bool` - Display actions one below the other
"""
function card_actions(args...; kwargs...)
  q__card__actions(args...; kw(kwargs)...)
end

const cardactions = card_actions


"""
    card_1

Premade card component with many options. This is a good starting point for creating your own card component.
Allows for:
  * showing and hidding of avatar, media, separator.
  * customizing avatar, media, title, subtitle, content, buttons, menu.
  * controlling the content of the components with buttons_component, menu_component, media_component, content.
  * customizing the props of the components with card_props, media_props, title_props, subtitle_props, content_props, separator_props.

# Example
card_1(; show_avatar = false, title = "Welcome to Genie", subtitle = "The best Julia Framework", content = "",
            buttons_component = nothing, menu_component = nothing, show_separator = false)
"""
function card_1(args...;
                show_avatar::Bool = true,
                show_media::Bool = true,
                show_separator::Bool = true,
                avatar_img::Union{Nothing,ParsedHTMLString,AbstractString} = "https://api.multiavatar.com/12345.png",
                avatar_title::Union{Nothing,ParsedHTMLString,AbstractString} = "",
                avatar_subtitle::Union{Nothing,ParsedHTMLString,AbstractString} = "",
                media_image::Union{Nothing,ParsedHTMLString,AbstractString} = nothing, # "https://cdn.quasar.dev/img/mountains.jpg",
                media_component::Union{Nothing,ParsedHTMLString,AbstractString} = nothing,
                title::Union{Nothing,ParsedHTMLString,AbstractString} = "",
                subtitle::Union{Nothing,ParsedHTMLString,AbstractString} = "",
                content::Union{Nothing,ParsedHTMLString,AbstractString} = "",
                buttons_component::Union{Nothing,ParsedHTMLString,AbstractString} = ParsedHTMLString("""<q-btn flat>Action 1</q-btn><q-btn flat>Action 2</q-btn>"""),
                menu_component::Union{Nothing,ParsedHTMLString,AbstractString} = ParsedHTMLString("""<q-item clickable><q-item-section>Menu 1</q-item-section></q-item>"""),
                card_props::Dict = Dict(),
                media_props::Dict = Dict(),
                title_props::Dict = Dict(),
                subtitle_props::Dict = Dict(),
                content_props::Dict = Dict(),
                separator_props::Dict = Dict(),
                kwargs...)
  avatar_component = if show_avatar
    item([
      itemsection(avatar=true, [
        avatar([
          img(src=avatar_img)
        ])
      ])

      itemsection([
        itemlabel(avatar_title)
        itemlabel(avatar_subtitle; caption=true)
      ])
    ])
  else
    ""
  end

  media_component = if media_component !== nothing
    media_component
  elseif show_media
    img(; src=media_image, kw(media_props)...)
  else
    ""
  end

  buttons_component = if buttons_component !== nothing
    Html.div([
      cardactions([
        buttons_component
      ])
    ]; class="col")
  else
    ""
  end

  menu_component = if menu_component !== nothing
    Html.div(class="col-auto", [
      btn(color="grey-7", round=true, flat=true, icon="more_vert", [
        menu(cover=true, autoclose=true, [
          list([
            menu_component
          ])
        ])
      ])
    ])
  else
    ""
  end

  card_separator = if show_separator
    separator(; kw(separator_props)...)
  else
    ""
  end

  bottom_section = if isempty(buttons_component) || isempty(menu_component)
    ""
  else
    card_separator
    cardsection([
      Html.div([
        buttons_component
        menu_component
      ]; class="row items-center no-wrap")
    ])
  end

  card([
    avatar_component
    media_component
    cardsection([
      Html.div(title; class="text-h6", kw(title_props)...),
      Html.div(subtitle; class="text-subtitle2", kw(subtitle_props)...)
    ])
    cardsection(content; kw(content_props)...)
    bottom_section
  ]; flat=true, bordered=true, kw(card_props)...)
end

end
