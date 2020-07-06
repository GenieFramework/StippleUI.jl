module API

function attr_loading(loading::Union{Bool,Symbol}, k, v)
  if (isa(loading, Bool) && loading) || (isa(loading, Symbol))
    k = (k..., (isa(loading, Symbol) ? Symbol("loading!") : Symbol("loading")))
    push!(v, loading)
  end

  k
end

function attr_textcolor(textcolor::Union{String,Nothing}, k, v)
  if textcolor !== nothing
    k = (k..., Symbol("text-color"))
    push!(v, textcolor)
  end

  k
end

function attr_iconright(iconright::Union{String,Nothing}, k, v)
  if iconright !== nothing
    k = (k..., Symbol("icon-right"))
    push!(v, iconright)
  end

  k
end

function attr_nowrap(nowrap::Union{Bool,Nothing}, k, v)
  if nowrap !== nothing
    k = (k..., Symbol("no-wrap"))
    push!(v, nowrap)
  end

  k
end

end