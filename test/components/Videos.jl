module Videos

using Genie,Stipple, StippleUI

export VideoModel

Genie.config.cors_headers["Access-Control-Allow-Origin"]  =  "*"
Genie.config.cors_headers["Access-Control-Allow-Headers"] = "Content-Type"
Genie.config.cors_headers["Access-Control-Allow-Methods"] = "GET,POST,PUT,DELETE,OPTIONS"
Genie.config.cors_allowed_origins = ["*"]

@reactive! mutable struct VideoModel <: ReactiveModel
  v_ratio::R{String} = "16/9"
end

function ui(video_model)
  page(
    video_model,
    title = "Video Components",
    class = "q-pa-md",
    [
      video(ratio! =:v_ratio, src="https://www.youtube.com/embed/k3_tw44QsZQ?rel=0")
    ]
  )
end

function factory()
  video_model = VideoModel |> init
  video_model
end

end