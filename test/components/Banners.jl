module Banners

using Stipple, StippleUI

export BannerModel

@reactive! mutable struct BannerModel <: ReactiveModel
end


function ui(banner_model)
  page(
    banner_model,
    title = "Banners Components",
    class = "q-pa-md q-gutter-sm",
    [
      banner("Unfortunately, the credit card did not go through, please try again.", class="bg-primary text-white", [
        template("", "v-slot:action", [
          btn("Dismiss", flat=true, color="white"),
          btn("Update Credit Card", flat=true, color="white")
        ])
      ]),
      banner("Could not retrieve travel data.", rounded=true, class="bg-grey-3", [
        template("", "v-slot:avatar", [
          imageview(src="https://cdn.quasar.dev/img/mountains.jpg", style="width: 100px; height:64px")
        ]),
        template("", "v-slot:action", [
          btn("Retry", flat=true, color="white")
        ])
      ])
    ]
  )
end

function factory()
  banner_model = BannerModel |> init
  banner_model
end

end
