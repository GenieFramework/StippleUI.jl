module Lists

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export list, item, item_section, itemsection, item_label, itemlabel
export List, Item

register_normal_element("q__list", context = @__MODULE__)
register_normal_element("q__item", context = @__MODULE__)
register_normal_element("q__item__section", context = @__MODULE__)
register_normal_element("q__item__label", context = @__MODULE__)


# OOP API
mutable struct List
  args
  kwargs
end

List(args...; kwargs...) = List(args, kwargs)

Base.string(l::List) = list(l.args...; l.kwargs...)

mutable struct Item
  args
  kwargs
end

Item(args...; kwargs...) = Item(args, kwargs)

function Item(i::Item, args...; kwargs...)
  ix = Item()
  ix.args = (i.args..., args...)
  ix.kwargs = (i.kwargs..., kwargs...)

  ix
end

Base.string(i::Item) = item(i.args...; i.kwargs...)

"""
      list(args...; kwargs...)

The `list` and `item` are a group of components which can work together to present multiple line items vertically as a single continuous element. They are best suited for displaying similar data types as rows of information, such as a contact list, a playlist or menu. Each row is called an Item. `item` can also be used outside of a `list` too.
    
----------
# Examples
----------

### View

```julia-repl
julia>  list(bordered=true, separator=true, [
          item(clickable=true, vripple=true, [
            itemsection("Single line item")
          ]),

          item(clickable=true, vripple=true, [
            itemsection([
              itemlabel("Item with caption"),
              itemlabel("Caption", caption=true)
            ])
          ]),

          item(clickable=true, vripple=true, [
            itemsection([
              itemlabel("OVERLINE", overline=true),
              itemlabel("Item with caption")
            ])
          ])
        ])
```

-----------
# Arguments
-----------

1. Content
      * `separator::Bool` - Applies a separator between contained items
      * `padding:Bool` - Applies a material design-like padding on top and bottom

2. Style
      * `bordered::Bool` - Applies a default border to the component
      * `dense::Bool` - Dense mode; occupies less space
      * `dark::Bool` - Notify the component that the background is a dark color
"""
function list(args...; kwargs...)
  q__list(args...; kw(kwargs)...)
end

# server side iteration
function list(data::Vector{T}, i::Item, args...; kwargs...) where {T}
  content = []
  for d in data
    push!(content, Item(i, [d]) |> string)
  end

  list(join(content), args...; kwargs...)
end

# client side iteration
function list(binding::Symbol, i::Item, args...; kwargs...)
  list(
    Item(i, ["{{__b__}}"], @recur("__b__ in $binding"), key! = "__b__")
  )
end

"""
      item(args...; kwargs...)

-----------
# Arguments
-----------

1. Content
      * `tag::String` - HTML tag to render; Suggestion: use 'label' when encapsulating a `checkbox`/`radio`/`toggle` so that when user clicks/taps on the whole item it will trigger a model change for the mentioned components ex. `a` `label` `div`
      * `insetlevel::Int` - Apply an inset; Useful when avatar/left side is missing but you want to align content with other items that do have a left side, or when you're building a menu ex. `insetlevel!="1"`
2. General
      * `tabindex::Union{Int, String}` - Tabindex HTML attribute value ex. `0` `100`
3. Navigation
      * `href::String` - Native <a> link href attribute; Has priority over the 'to'/'exact'/'replace' props ex. `http://genieframework.com`
      * `target::String` - Native <a> link target attribute; Use it only along with 'href' prop; Has priority over the 'to'/'exact'/'replace' props `_blank` `_self` `_parent` `_top`
4. State
      * `disable::Bool` - Put component in disabled mode
      * `active::Bool` - Put item into 'active' state
      * `clickable::Bool` - Is `item` clickable? If it's the case, then it will add hover effects and emit 'click' events
      * `manualfocus::Bool` - Put item into a manual focus state; Enables 'focused' prop which will determine if item is focused or not, rather than relying on native hover/focus states
      * `focused::Bool` - Determines focus state, ONLY if 'manual-focus' is enabled / set to true
5. Style
      * `dark::Bool` - Notify the component that the background is a dark color
      * `dense::Bool` - Dense mode; occupies less space
"""
function item(args...; kwargs...)
  q__item(args...; kw(kwargs)...)
end

"""
      item_section(args...; kwargs...)

-----------
# Arguments
-----------

* `avatar::Bool` - Render an avatar item side (does not needs 'side' prop to be set)
* `thumbnail::Bool` - Render a thumbnail item side (does not needs 'side' prop to be set)
* `side::Bool` - Renders as a side of the item
* `top::Bool` - Align content to top (useful for multi-line items)
* `nowrap::Bool` - Do not wrap text (useful for item's main content)
"""
function item_section(args...; kwargs...)
  q__item__section(args...; kw(kwargs)...)
end
const itemsection = item_section

"""
      item_label(args...; kwargs...)

-----------
# Arguments
-----------

1. Behaviour
      * `lines::Union{Int, String}` - Apply ellipsis when there's not enough space to render on the specified number of lines; ex. `1` `3` `lines!="2"`
2. Content
      * `overline::Bool` - Renders an overline label
      * `caption::Bool` - Renders a caption label
      * `header::Bool` - Renders a header label
      * `lines::Union{Int, String}` - Apply ellipsis when there's not enough space to render on the specified number of lines; `1` `3` `lines!="2"`
"""
function item_label(args...; kwargs...)
  q__item__label(args...; kw(kwargs)...)
end
const itemlabel = item_label

end
