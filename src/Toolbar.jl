module Toolbar

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export toolbar, toolbartitle

register_normal_element("q__toolbar", context = @__MODULE__)
register_normal_element("q__toolbar__title", context = @__MODULE__)

"""
    toolbar(args...; kwargs...)

`toolbar` is a component usually part of Layout Header and Footer, but it can be used anywhere on the page.

----------
# Examples
----------

### View
```julia-repl
julia> 
```

----------
# Arguments
----------

1. Behaviour
      * 
"""
function toolbar(args...; kwargs...)
  q__toolbar(args...; kw(kwargs)...)
end

"""
    toolbartitle(args...; kwargs...)

----------
# Examples
----------

### View
```julia-repl
julia> 
```

----------
# Arguments
----------

* `shrink::Bool` -  By default, `toolbartitle` is set to grow to the available space. However, you can reverse that with this prop
"""
function toolbartitle(args...; kwargs...)
  q__toolbar__title(args...; kw(kwargs)...)
end

end
