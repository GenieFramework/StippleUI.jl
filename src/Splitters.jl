module Splitters

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export splitter

register_normal_element("q__splitter", context = @__MODULE__)

"""
    splitter(fieldname::Symbol, args...; kwargs...)

----------
# Examples
----------

### Model
```julia-repl
julia> @vars SplitterModel begin
            splitterM::R{Int} = 50
       end
```

### View
```julia-repl
julia> splitter(:splitterM, style="height: 400px", [
        template("", "v-slot:before", [
          Html.div(class="q-pa-md", [
            Html.div("Before", class="text-h4 q-mb-md"),
            Html.div("{{ n }}. Lorem ipsum dolor sit, amet consectetur adipisicing elit.
               Quis praesentium cumque magnam odio iure quidem, quod illum numquam possimus
               obcaecati commodi minima assumenda consectetur culpa fuga nulla ullam. In, libero.",
              class = "q-my-md",
              @for(:"n in 20"), key! = "n")
          ])
        ]),
        template("", "v-slot:after", [
          Html.div(class="q-pa-md", [
            Html.div("After", class="text-h4 q-mb-md")
              Html.div("{{ n }}. Lorem ipsum dolor sit, amet consectetur adipisicing elit.
               Quis praesentium cumque magnam odio iure quidem, quod illum numquam possimus
               obcaecati commodi minima assumenda consectetur culpa fuga nulla ullam. In, libero.",
              class = "q-my-md",
              @for(:"n in 20"), key! = "n")
          ])
        ])
       ])
```

----------
# Arguments
----------

1. Content
      * `horizontal::Bool` - Allows the splitter to split its two panels horizontally, instead of vertically
      * `limits::Vector` - An array of two values representing the minimum and maximum split size of the two panels; When 'px' unit is set then you can use Infinity as the second value to make it unbound on the other side
2. Model
      * `reverse::Bool` - Apply the model size to the second panel (by default it applies to the first)
      * `unit::String` - CSS unit for the model
      * `emitimmediately::Bool` - Emit model while user is panning on the separator
      * `limits::Vector` - An array of two values representing the minimum and maximum split size of the two panels; When 'px' unit is set then you can use Infinity as the second value to make it unbound on the other side
3. State
      * `disable::Bool` - Put component in disabled mode
4. Style
      * `classbefore::Union{Vector,String,Dict}` - Class definitions to be attributed to the 'before' panel ex. `"bg-deep-orange"`
      * `classafter::Union{Vector,String,Dict}` - Class definitions to be attributed to the 'after' panel ex. `"bg-deep-orange"`
      * `separatorclass::Union{Vector,String,Dict}` - Class definitions to be attributed to the splitter separator ex. `"bg-deep-orange"`
      * `separatorstyle::Union{Vector,String,Dict}` - Style definitions to be attributed to the splitter separator ex. `"border-color: #ff0000;"`
      * `dark::Bool` - Applies a default lighter color on the separator; To be used when background is darker; Avoid using when you are overriding through separator-class or separator-style props 
"""
function splitter(fieldname::Symbol, args...; kwargs...)
  q__splitter(args...; kw([:fieldname => fieldname, kwargs...])...)
end

end
