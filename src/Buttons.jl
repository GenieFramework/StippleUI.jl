module Buttons

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export btn, btngroup, btndropdown, Btn

register_normal_element("q__btn", context = @__MODULE__)
register_normal_element("q__btn__group", context = @__MODULE__)
register_normal_element("q__btn__dropdown", context = @__MODULE__)

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
"""
function btn( label::String = "",
              args...;
              content::Union{String,Vector,Function} = "",
              kwargs...)
  q__btn([isa(content, Function) ? content() : join(content)],
          args...;
          label = label, kw(kwargs)...
  )
end

function btn( content::Union{Function,Vector},
              label::String = "",
              args...;
              kwargs...)
  btn(label, args...; content = content, kwargs...)
end

function btn( args...;
              label::String = "",
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

  Btn(label::String = "",
      args...;
      content::Union{String,Vector,Function} = "",
      kwargs...) = new(fieldname, args, mask, kwargs)
end

Base.string(bt::Btn) = btn(bt.label, bt.args...; bt.content, bt.kwargs...)

"""
You can conveniently group `btn` and `btndropdown` using `btngroup`. Be sure to check those component’s respective pages to see their props and methods.
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
"""
function btndropdown(args...; kwargs...)
  q__btn__dropdown(args...; kw(kwargs)...)
end


end
