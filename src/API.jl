module API

using Stipple
import Genie

export attributes, @wrapper

function attributes(kwargs::Vector{T}, mappings::Dict{String,String} = Dict{String,String}())::NamedTuple where {T}
  keynames = collect(keys(mappings))
  attrs = Dict()
  kwargs = Dict(kwargs)
  mapped = false

  for (k,v) in kwargs
    v === nothing && continue
    mapped = false

    if string(k) in keynames
      k = mappings[string(k)]
      mapped = true
    end

    attrs[string((isa(v, Symbol) && ! mapped ? ":" : ""), "$k") |> Symbol] = v
  end

  NamedTuple(attrs)
end

end