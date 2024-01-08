row() do
  cell() do
    heading("File uploader demo")
  end
end
row() do
  cell() do
    uploader( multiple = true,
              accept = :accept,
              maxfilesize = :maxfilesize,
              maxfiles = 10,
              autoupload = true,
              hideuploadbtn = true,
              label = "Upload Images",
              nothumbnails = true,
              style="max-width: 95%; width: 95%; margin: 0 auto;",

              @on("rejected", :rejected),
              @on("uploaded", :uploaded),
              @on("finish", :finished),
              @on("failed", :failed),
              # @on("uploading", :uploading),
              # @on("start", :started),
              # @on("added", :added),
              # @on("removed", :removed),
            )
  end
end
row() do
  cell() do
    img(src! = "imgsrc", style="max-width: 95%; margin-left: 25px", placeholder__src="/img/placeholder-image.jpg")
  end
end