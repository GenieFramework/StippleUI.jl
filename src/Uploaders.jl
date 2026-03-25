module Uploaders

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export uploader

register_normal_element("q__uploader", context = @__MODULE__)

Base.@kwdef mutable struct UploadedFile
  tmppath::String
  name::String
  channel::String
end

# handlers receive an UploadedFile and return an UploadedFile
const upload_handlers = Function[]

upload_route::Genie.Router.Route = route("/____/upload/:channel", method = POST) do
  for f in Genie.Requests.filespayload()
    uf = UploadedFile(tempname(), f[2].name, params(:channel))

    try
      write(uf.tmppath, f[2].data)
    catch e
      @error "Error saving uploaded file: $e"
      rethrow(e)
    end

    push_uploaded_files(uf)

    for h in upload_handlers
      try
        uf::UploadedFile = uf |> h
      catch e
        @error "Error in upload handler: $e"
        if Genie.Configuration.isdev()
          rethrow(e)
        end
      end
    end

  end

  # the response needs to be a HTTP response with a json body, which is what Genie.Renderer.Json.json does
  # otherwise the uploader will throw an error at the console
  Genie.Renderer.Json.json("OK")
end

function disable_uploads()
  Genie.Router.delete!(:post______upload_by_channel)
end

function enable_uploads()
  route(upload_route)
end

function __init__()
  enable_uploads()
end


function push_uploaded_files(uf::UploadedFile)
  filedict = Dict{String,String}(
    "name" => uf.name,
    "channel" => uf.channel,
    "path" => uf.tmppath
  )

  Stipple.WEB_TRANSPORT[].broadcast(
    Genie.WebChannels.tagbase64encode(""">eval:Genie.findApp('$(uf.channel)').fileuploads = $(js_attr(filedict))"""),
    channels = uf.channel
  )

  nothing
end


"""
      uploader(args...; kwargs...)

Stipple supplies a way for you to upload files through the `uploader` component.

----------
### Examples
----------

### View

```julia-repl
julia> uploader(label="Upload Image", autoupload=true, multiple=true, method="POST", url="/upload", field__name="img")
```

-----------
### Arguments
-----------

1. Behaviour
      * `multiple::Bool` - Allow multiple file uploads
      * `accept::String` - Comma separated list of unique file type specifiers. Maps to 'accept' attribute of native input type=file element ex. `.jpg, .pdf, image/*` `image/jpeg, .pdf`
      * `capture::String` - Optionally, specify that a new file should be captured, and which device should be used to capture that new media of a type defined by the 'accept' prop. Maps to 'capture' attribute of native input type=file element ex. `user` `environment`
      * `maxfilesize::Union{Int, String}` - Maximum size of individual file in bytes ex. `1024` `1048576`
      * `maxtotalsize::Union{Int, String}` - Maximum size of all files combined in bytes ex. `1024` `1048576`
      * `maxfiles::Union{Int, String}` - Maximum number of files to contain ex. `maxfiles!="5"` `10`
      * `filter::Function` - Custom filter for added files; Only files that pass this filter will be added to the queue and uploaded; For best performance, reference it from your scope and do not define it inline ex. `filter!="files => files.filter(file => file.size === 1024)"`
      * `autoupload::Bool` - Upload files immediately when added
      * `hideuploadbtn::Bool` - Don't show the upload button
2. Content
      * `label::Union{String,Symbol,Nothing}` - Label for the uploader ex. `Upload photo here`
      * `nothumbnails::Bool` - Don't display thumbnails for image files
3. State
      * `disable::Bool` - Put component in disabled mode
      * `readonly::Bool` - Put component in readonly mode
4. Style
      * `color:String` - Color of the component from the [Color Palette](https://quasar.dev/style/color-palette) eg. `primary` `teal-10`
      * `textcolor::String` - Overrides text color (if needed); Color name from the [Color Palette](https://quasar.dev/style/color-palette) eg. `primary` `teal-10`
      * `dark::Bool` - Dark mode
      * `square::Bool` - Removes border-radius so borders are squared
      * `flat::Bool` - Applies a flat design (no default shadow)
      * `bordered::Bool` - Applies a default border to the component
5. Upload
      * `url::String` - URL or path to the server which handles the upload. Takes String or factory function, which returns String. Function is called right before upload; If using a function then for best performance, reference it from your scope and do not define it inline ex. `"files => `https://example.com?count=\${files.length}`"` `https://example.com/path`
      * `method::String` - HTTP method to use for upload; Takes String or factory function which returns a String; Function is called right before upload; If using a function then for best performance, reference it from your scope and do not define it inline default. `POST` ex. `POST` `PUT`
      * `fieldname::String` - Field name for each file upload; This goes into the following header: 'Content-Disposition: form-data; name="__HERE__"; filename="somefile.png"; If using a function then for best performance, reference it from your scope and do not define it inline default value. `(file) => file.name` ex. `backgroundFile` `fieldname!="(file) => 'background' + file.name"`
      * `headers::Union{Vector{Dict(String, String)}, String}` - Array or a factory function which returns an array; Array consists of objects with header definitions; Function is called right before upload; If using a function then for best performance, reference it from your scope and do not define it inline ex. `[{name: 'Content-Type', value: 'application/json'}, {name: 'Accept', value: 'application/json'}]`
      * `formfields::Union{Vector{Dict(String, String)}, String}` - Array or a factory function which returns an array; Array consists of objects with additional fields definitions (used by Form to be uploaded); Function is called right before upload; If using a function then for best performance, reference it from your scope and do not define it inline ex. `[{name: 'my-field', value: 'my-value'}]`
      * `with-credentials::Union{Bool, String}` - Sets withCredentials to true on the XHR that manages the upload; Takes boolean or factory function for Boolean; Function is called right before upload; If using a function then for best performance, reference it from your scope and do not define it inline ex. `with-credentials` `with!="files => ...."`
      * `sendraw::Union{Bool, String}` - Send raw files without wrapping into a Form(); Takes boolean or factory function for Boolean; Function is called right before upload; If using a function then for best performance, reference it from your scope and do not define it inline ex. `sendraw` `sendraw!="files => ...."`
      * `batch::Union{Bool, String}` - Upload files in batch (in one XHR request); Takes boolean or factory function for Boolean; Function is called right before upload; If using a function then for best performance, reference it from your scope and do not define it inline ex. `"files => files.length > 10"`
6. Events
      * Quasar uploader events can be handled with `@on(event_name, handler, preprocessor)`.
      * To include uploaded file names in the `@event :uploaded` payload, use a preprocessing handler as the third argument of `@on`:

```julia-repl
julia> uploader(accept=".csv", @on("uploaded", :uploaded, :addFileInfo))
```

      * The `:addFileInfo` helper is defined in `StippleUI/assets/js/mixins.js` which adds the original filename to the event data for each uploaded file. This is necessary because in some cases, e.g. in case of the click event not all fields are automatically converted by JSON.stringify.
      * To add the event handler to the model, use
```julia
  @event :uploaded begin
      @info "File uploaded"
      @info event
      @info __model__
  end
```
      where `__model__` refers to the model of the uploader component that triggered the event and event contains the payload of the event
"""
function uploader(args...;
                  url::Union{AbstractString,Nothing} = nothing,
                  method::AbstractString = "POST",
                  kwargs...)
  kws = []

  # use default upload url if none is provided and method is POST
  if url === nothing && method == "POST"
    url = Symbol("() => { return '$(Genie.config.base_path)/____/upload/' + this.channel_ }")
  end

  if url !== nothing
    push!(kws, :url => url)
  end

  q__uploader(args...; kw([kws..., kwargs...])...)
end

end
