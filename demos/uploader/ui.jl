heading("File uploader demo")
uploader( multiple = true,
          accept = ".jpg, .jpeg, .pdf, image/*",
          maxfilesize = 102400000000,
          maxfiles = 10,
          autoupload = true,
          hideuploadbtn = true,
          method = "POST",
          label = "Upload Images",
          nothumbnails = false,
          dark = false,
          square = false,
          flat = false,
          bordered = false,

          # @on("rejected", :rejected),
          # @on("added", :added),
          # @on("removed", :removed),
          # @on("uploaded", :uploaded),
          # @on("uploading", :uploading),
          # @on("start", :started),
          # @on("finish", :finished),
          # @on("failed", :failed)
        )