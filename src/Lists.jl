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
Base.string(i::Item) = item(i.args...; i.kwargs...)


# Functional API

function list(args...; kwargs...)
  q__list(args...; kw(kwargs)...)
end

# server side iteration
function list(data::Vector{T}, i::Item, args...; kwargs...) where {T}
  content = []
  for d in data
    push!(content, Item([d]) |> string)
  end

  list(join(content), args...; kwargs...)
end

# client side iteration
function list(binding::Symbol, i::Item, args...; kwargs...)
  list(
    Item("{{__b__}}", @recur("__b__ in $binding"), key! = "__b__")
  )
end

# list items

function item(args...; kwargs...)
  q__item(args...; kw(kwargs)...)
end


function item_section(args...; kwargs...)
  q__item__section(args...; kw(kwargs)...)
end
const itemsection = item_section


function item_label(args...; kwargs...)
  q__item__label(args...; kw(kwargs)...)
end
const itemlabel = item_label

end
