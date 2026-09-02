module Notifications

using Stipple

export notify

"""
    notify(model::ReactiveModel, message::AbstractString, type::Union{Symbol, String, Nothing} = nothing; kwargs...)

Display a notification on the client (via Quasar's `$q-notify`)

Parameters:
- `type` (optional): specifies the display type, e.g. `:positive`, `:negative`, `:warning`, `:info`, `:ongoing`.
- `interpolation`: enables Vue interpolation syntax, values need to be prefixed by `"this"`, e.g.
`"{{ this.name }}"`
- Keyword arguments, e.g. `html`, `caption`, are passed 1:1 to Quasar's `$q-notify`, for details, see https://quasar.dev/quasar-plugins/notify

# Example
```
notify(model, "Hello world!", :positive, icon = :tag_faces, caption = "5 minutes ago")
notify(model, "Hello, I am {{ this.name }}", interpolation = true)
```
"""
function Base.notify(model::ReactiveModel, message::AbstractString, type::Union{Symbol, String, Nothing} = nothing; interpolation = false, kwargs...)
  if interpolation && (contains(message, "{{") || contains(message, "\${"))
    dummy = "__message_dummy__"
    d = filter!(x -> x[2] !== nothing, Stipple.opts(; type, message = dummy, kwargs...))
    js_dict = strip(json(d), '"')
    message = replace(message, "{{" => "\${", "}}" => "}")
    js_dict = replace(js_dict, "\"$dummy\"" => "`$message`")
  else
    d = filter!(x -> x[2] !== nothing, Stipple.opts(; type, message, kwargs...))
    js_dict = strip(json(d), '"')
  end
  run(model, "window?.GENIEMODEL?.\$q.notify($js_dict)")
end

end