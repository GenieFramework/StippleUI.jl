module Checkbox

using Revise

import Genie, Stipple
import Genie.Renderer.Html: HTMLString, normal_element

using Stipple

export checkbox

Genie.Renderer.Html.register_normal_element("q__checkbox", context = @__MODULE__)

function checkbox(fieldname::Symbol; args...)
  q__checkbox(v__model=fieldname; args...)
end

end