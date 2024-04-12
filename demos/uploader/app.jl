module App

using Random, Base64
using GenieFramework
@genietools

@app begin
  @out accept = ".jpg, .jpeg, .pdf, image/*"
  @out imgsrc = "/img/placeholder-image.jpg"
  @out maxfilesize = 10 * 1024 * 1024
  @out caption = "No image selected"

  @event rejected begin
    @info "rejected"
    notify(__model__,"File rejected. Please make sure it is a valid image file.")
  end

  # @event added begin
  #   @info "added"
  #   # @info params(:payload)["event"]
  # end

  # @event removed begin
  #   @info "removed"
  #   # @info params(:payload)["event"]
  # end

  # @event started begin
  #   @info "started"
  #   # @info params(:payload)["event"]
  # end

  # @event uploading begin
  #   @info "uploading"
  #   # @info params(:payload)["event"]
  # end

  @event uploaded begin
    @info "uploaded"
  end

  @event finished begin
    @info "finished"
  end

  @event failed begin
    @info "failed"
    notify(__model__,"File upload failed. Please try again.")
  end

  @onchange fileuploads begin
    if ! isempty(fileuploads)
      @info "File was uploaded: " fileuploads
      filename = Random.randstring(10) * "_" * base64encode(fileuploads["name"])

      try
        isdir(joinpath("public", "uploads")) || mkdir(joinpath("public", "uploads"))
        mv(fileuploads["path"], joinpath("public", "uploads", filename))
      catch e
        @error "Error processing file: $e"
        notify(__model__,"Error processing file: $(fileuploads["name"])")
      end

      imgsrc = "/uploads/$filename"
      fileuploads = Dict{AbstractString,AbstractString}()
    end
  end
end

@page("/", "ui.jl")

end
