module Uploaders

using Stipple, StippleUI

@reactive mutable struct Model <: ReactiveModel
end

function ui(model)
  page(
    form_model,
    title = "Form Components",
    class = "q-pa-md",
    [
        uploader(label="Upload Image", :auto__upload, :multiple, method="POST",
        url="/upload", field__name="img")
      
    ])
end



end