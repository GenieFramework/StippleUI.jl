module App

using GenieFramework
@genietools

const UPLOADS_FOLDER = "public/uploads"
Genie.Watch.unwatch(UPLOADS_FOLDER)

@app begin
	@event rejected begin
		@info "rejected"
		@notify("File rejected")
	end

	@event uploaded begin
		@info "File uploaded"
	end

	@event finished begin
		@info "Upload finished"
	end

	@event failed begin
		@info "Upload failed"
		@notify("File upload failed. Please try again.")
	end

	@onchange fileuploads begin
        uploaded_file = UploadedFile(fileuploads)
        try
            cp(uploaded_file, UPLOADS_FOLDER; force = true)
        catch e
            @error "Error processing file: $e"
            @notify("Error processing file: $(uploaded_file.name)")
            # rethrow(e)
        end
	end
end

@page("/", "app.jl.html")

end
