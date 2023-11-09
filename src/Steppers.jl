module Steppers

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export  step, stepper, steppernavigation

register_normal_element("q__stepper", context = @__MODULE__)
register_normal_element("q__step", context = @__MODULE__)
register_normal_element("q__stepper__navigation", context = @__MODULE__)

"""
    stepper(fieldname::Symbol, args...; kwargs...)


----------
# Example App
----------

```julia-repl
@app begin
  @in step = 1
end

ui() = [
    htmldiv(class = "q-pa-md",
        stepper(:step, ref = "stepper", color = "primary", animated = "", [
            StippleUI.step(name = R"1", title = "Select campaign settings", icon = "settings", done = R"step > 1", 
                \"\"\"
                For each ad campaign that you create, you can control how much you're willing to
                spend on clicks and conversions, which networks and geographical locations you want
                your ads to show on, and more.
                \"\"\"
            ),
            StippleUI.step(name = R"2", title = "Create an ad group", caption = "Optional", icon = "create_new_folder", done = R"step > 2",
                "An ad group contains one or more ads which target a shared set of keywords."
            ),
            StippleUI.step(name = R"3", title = "Ad template", icon = "assignment", disable = "", 
                "This step won't show up because it is disabled."
            ),
            StippleUI.step(name = R"4", title = "Create an ad", icon = "add_comment",
                \"\"\"
                Try out different ad text to see what brings in the most customers, and learn how to
                enhance your ads using features like ad extensions. If you run into any problems with
                your ads, find out how to tell if they're running and how to resolve approval issues.
                \"\"\"
            ),
            template(var"v-slot:navigation" = "",
                steppernavigation([
                    btn(R"step === 4 ? 'Finish' : 'Continue'", @click("\$refs.stepper.next()"), color = "primary", ),
                    btn("Back", @if("step > 1"), flat = "", color = "primary", @click("\$refs.stepper.previous()"), class = "q-ml-sm", )
                ])
            )
        ])
    )
]

ui()

@page("/", ui)

up()
```

----------
# Arguments
----------

1. Behaviour
    *  `keep-alive::Boolean` - Equivalent to using Vue's native <keep-alive> component on the content
    *  `keep-alive-include::String | Array | RegExpv1.15+` - Equivalent to using Vue's native include prop for <keep-alive>; Values must be valid Vue component names

        Examples: `"a,b"`, `"/a|b/"`, `['a', 'b']`
    *  `keep-alive-exclude::String | Array | RegExpv1.15+` - Equivalent to using Vue's native exclude prop for <keep-alive>; Values must be valid Vue component names

        Examples: `"a,b"`, `"/a|b/"`, `['a', 'b']`
    *  `keep-alive-max::Number` - Equivalent to using Vue's native max prop for <keep-alive>

        Example: `2`
    *  `animated::Boolean` - Enable transitions between panel (also see 'transition-prev' and 'transition-next' props)
    *  `infinite::Boolean` - Makes component appear as infinite (when reaching last panel, next one will become the first one)
    *  `swipeable::Boolean` - Enable swipe events (may interfere with content's touch/mouse events)
    *  `vertical::Boolean` - Put Stepper in vertical mode (instead of horizontal by default)
    *  `transition-prev::String` - One of Quasar's embedded transitions (has effect only if 'animated' prop is set)

        Default value: `"slide-right/slide-down"`\n
        Examples: `"fade"`, `"slide-down"`
    *   `transition-next::String` - One of Quasar's embedded transitions (has effect only if 'animated' prop is set)

        Default value: `"slide-left/slide-up"`\n
        Examples: `"fade"`, `"slide-down"`
    *   `header-nav::Boolean` - Allow navigation through the header
    *   `contracted::Boolean` - Hide header labels on narrow windows
4. Style
    *   `dark::Boolean` - Notify the component that the background is a dark color
    *   `flat::Boolean` - Applies a 'flat' design (no default shadow)
    *   `bordered::Boolean` - Applies a default border to the component
    *   `header-class::String` - Class definitions to be attributed to the header

        Example: `"my-special-class"`
"""
function stepper(fieldname::Symbol, args...; kwargs...)
  q__stepper(args...; kw([:fieldname => fieldname, kwargs...])...)
end


"""
    step(args...; kwargs...)


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
function step(args...; kwargs...)
  q__step(args...; kw(kwargs)...)
end

"""
    steppernavigation(args...; kwargs...)


----------
# Examples
----------

### View
```julia-repl
julia> 
])
```

----------
# Arguments
----------

1. Behaviour
      * 
"""
function steppernavigation(args...; kwargs...)
  q__stepper__navigation(args...; kw(kwargs)...)
end

end
