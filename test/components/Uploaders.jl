module Uploaders

using Stipple, StippleUI

@reactive mutable struct UploaderModel <: ReactiveModel
end

function ui(uploader_model)
  page(
    uploader_model,
    title = "Form Components",
    class = "q-pa-md",
    [
        uploader(label="Upload Image", :auto__upload, :multiple, method="POST",
        url="/upload", field__name="img")
      
    ])
end

function factory()
  uploader_model = UploaderModel |> init
  uploader_model
end


end