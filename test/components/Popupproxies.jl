module Popupproxies

using Stipple, StippleUI

export PopupproxyModel

@reactive! mutable struct PopupproxyModel <: ReactiveModel
end

function ui(popupproxy_model)
  page(
    popupproxy_model,
    title = "Popup Proxies Components",
    [
      btn("Handles click", push=true, color="primary", [
        popupproxy([
          banner("You have lost connection to the internet. This app is offline.", [
            template("", "v-slot:avatar", [
              icon("signal_wifi_off", color="Primary")
            ])
          ])
        ])
      ])
    ]
  )
end

function factory()
  popupproxy_model = PopupproxyModel |> init
  popupproxy_model
end

end