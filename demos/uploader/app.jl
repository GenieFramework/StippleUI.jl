module App

using GenieFramework
@genietools

@app begin
  @event rejected begin
    @info "rejected"
    # @info params(:payload)["event"]
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

  # @event uploaded begin
  #   @info "uploaded"
  #   # @info params(:payload)["event"]
  # end

  # @event finished begin
  #   @info "finished"
  #   # @info params(:payload)["event"]
  # end

  # @event failed begin
  #   @info "failed"
  #   # @info params(:payload)["event"]
  # end

  @onchange fileuploads begin
    if ! isempty(fileuploads)
      @info "File was uploaded: " fileuploads
      fileuploads = Dict{AbstractString,AbstractString}()
    end

    @info "All good"
  end
end

@page("/", "ui.jl")

end