module Heading

using Revise

import Genie, Stipple

export heading

function heading(title::String = "";
                  class = "",
                  img = Genie.Renderer.Html.img(class="st-logo", src="/img/st-logo.svg"),
                  h = Genie.Renderer.Html.h1(title, class="st-header__title text-h3"),
                  kwargs...)

  Genie.Renderer.Html.header(; class="$(class) st-header q-pa-sm", kwargs...) do; [
    img
    h
  ]end
end

end