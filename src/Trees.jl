module Trees

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export tree, TreeSelectable

register_normal_element("q__tree", context = @__MODULE__)

function tree(args...; kwargs...)
  q__tree(args...; kw(kwargs)...)
end

Base.Base.@kwdef struct TreeSelectable
  var""::R{Vector{Dict{Symbol, Any}}} = Dict{Symbol, Any}[]
  _selected::R{String} = ""
  _expanded::R{Vector{String}} = String[]
  _ticked::R{Vector{String}} = String[]
end

TreeSelectable(tree; kwargs...) = TreeSelectable(; var"" = tree, kwargs...)

end