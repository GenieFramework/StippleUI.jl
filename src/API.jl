module API

using Stipple
import Genie

export attributes, @wrapper

function attributes(model::T,
                    kwargs::Vector{X},
                    mappings::Dict{String,String} = Dict{String,String}())::NamedTuple where {T<:Stipple.ReactiveModel, X}
  attributes(kwargs, mappings, )
end

function attributes(
                    kwargs::Vector{X},
                    mappings::Dict{String,String} = Dict{String,String}())::NamedTuple where {X}
  keynames = collect(keys(mappings))
  attrs = Dict()
  kwargs = Dict(kwargs)
  mapped = false

  for (k,v) in kwargs
    v === nothing && continue
    mapped = false

    if string(k) in keynames
      k = mappings[string(k)]
    end

    attr_key = string((isa(v, Symbol) && ! startswith(string(k), ":") ? ":" : ""), "$k") |> Symbol
    attr_val = isa(v, Symbol) && ! startswith(string(k), ":") ? Stipple.julia_to_vue(v) : v

    attrs[attr_key] = attr_val
  end

  NamedTuple(attrs)
end

end