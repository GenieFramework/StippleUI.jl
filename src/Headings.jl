module Headings

import Genie, Stipple

export heading

function heading( title::String = "";
                  class::String = "",
                  img::Union{AbstractString,Nothing} = nothing,
                  h = Genie.Renderer.Html.h1(title, class="st-header__title text-h3"),
                  content::Union{AbstractString,Nothing,Vector{AbstractString}} = nothing,
                  kwargs...)

  Genie.Renderer.Html.header(; class="$(class) st-header q-pa-sm", kwargs...) do; [
    img
    h
    content
  ]end
end

end
