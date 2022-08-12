module Notifications

using Stipple

export notify

"""
    notify(model::ReactiveModel, message::AbstractString, type::Union{Symbol, String, Nothing} = nothing; kwargs...)

Display a notification on the client, by using Quasar's `$q-notify`.
Types are e.g. `:positive`, `:negative`, `:warning`, `:info`, `:ongoing`.
All other arguments to `$q-notify` are supported via keyword arguments

# Example
`notify(model, "Hello world!", :positive, icon = :tag_faces, caption = "5 minutes ago")`
"""
function Base.notify(model::ReactiveModel, message::AbstractString, type::Union{Symbol, String, Nothing} = nothing; kwargs...)
  d = Stipple.opts(;type, message, kwargs...)
  js_dict = strip(json(d), '"')
  run(model, "this.\$q.notify($js_dict)")
end

end