module ChatMessages

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template, register_normal_element

export chatmessage

register_normal_element("q__chat__message", context = @__MODULE__)

"""
      chatmessage(text::Union{Symbol, Vector{<:AbstractString}, AbstractString} = "", args...; kwargs...)

The `chatmessage` which is really a chat entry that renders the data given by the reactive model

----------
# Examples
----------

### Model

```julia-repl
julia> @app begin
          @out textmsg1 = ["hey, how are you?"]
          @out textmsg2 = "I am good"
          @out messages = Dict{Symbol, Any}[]
       end
```

### View

```julia-repl
julia> chatmessage("This is static text", name="stella", sent = true)
julia> chatmessage(:textmsg1, name="dave", sent = true)
julia> chatmessage(Symbol("[textmsg2]"), name="stella")
julia> chatmessage(R"message.text", name = R"message.name", sent = R"message.sent", "", @recur("message in messages"))
```

-----------
# Arguments
-----------

1. Behaviour
      * `htmllabel::Bool` - Render the label as HTML; This can lead to XSS attacks so make sure that you sanitize the message first
      * `htmlname::Bool` - Render the name as HTML; This can lead to XSS attacks so make sure that you sanitize the message first
      * `htmlstamp::Bool` - Render the text as HTML; This can lead to XSS attacks so make sure that you sanitize the message first
      * `htmltext::Bool` - Render the stamp as HTML; This can lead to XSS attacks so make sure that you sanitize the message first
2. Content
      * `send::Bool` - Render as a sent message (so from current user)
      * `label::String` - Renders a label header/section only. Example `Friday, 18th`
      * `name::String` - Author's name. Example `John Doe`.
      * `avatar::String` - URL to the avatar image of the author. Example. `(public folder) src="boy-avatar.png"` | `(assets folder) src="~assets/boy-avatar.png"` | `(relative path format) :src="require('./my_img.jpg')"` | `(URL) src="https://placeimg.com/500/300/nature"`
      * `text::Union{AbstractString, Vector{<:AbstractString}}` - Array of strings that are the message body. Strings are not sanitized (see details in docs)
      * `stamp::String` - Creation timestamp. Example `13:55` `Yesterday at 13:51`
6. Style
      * `bgcolor::String` - Color name (from the Quasar Color Palette) for chat bubble background
      * `textcolor::String` - Color name (from the Quasar Color Palette) for chat bubble text
      * `size::String` - 1-12 out of 12(same as col-*)
7. Flexgrid
      * `colsize::Int/Symbol` - replaces the flexgrid parameter `size` as that is used already (see 6. Style)
"""
function chatmessage(text::Union{Symbol, Vector{<:AbstractString}, AbstractString} = "",
                    args...; kwargs...)
  text = if text isa Symbol
    text
  elseif text isa String
    Symbol("['$text']")
  else
    Symbol("['$(join(replace.(text, "'" => "\\'"), "', '"))']")
  end
  q__chat__message(args...; kw([:text => text, kwargs...], flexgrid_mappings = Dict(:size => :colsize))...)
end

end