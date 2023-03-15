module StippleUIParser

export parse_vue_html

using Stipple
using StippleUI
using OrderedCollections

using Genie.Logging
using Genie.Renderer.Html.HTMLParser

# add a method that doesn't interpret ':' as separator for namespace
function Base.getindex(node::EzXML.Node, attr::Symbol)
  str_ptr = ccall(
    (:xmlGetNoNsProp, EzXML.libxml2),
    Cstring,
    (Ptr{Cvoid}, Cstring),
    node.ptr, String(attr))
    str = unsafe_string(str_ptr)
    Libc.free(str_ptr)
    return str
  end

REV_DICT = Dict(zip(values(StippleUI.API.ATTRIBUTES_MAPPINGS), keys(StippleUI.API.ATTRIBUTES_MAPPINGS)))

function method_signature(m::Method)
  String[v for (v, T) in zip(split(m.slot_syms, '\0')[2:end-1], m.sig.types[2:end]) if ! (T isa Core.TypeofVararg)]
end

function method_signatures(mm::Union{Vector{Method}, Base.MethodList})
  sigs = Vector{String}[]
  for m in mm
    startswith("$(m.module)", "Stipple") || continue
    sig = method_signature(m)
    (length(sig) == 0 || sig[1] ∉ ["children", "content"]) && push!(sigs, sig)
  end
  sort(union(sigs), lt = (x, y) -> length(x) > length(y))
end

method_signatures(f::Function) = method_signatures(methods(f))

function attr_dict(n::EzXML.Node)
  LittleDict(a.name => n[Symbol(a.name)] for a in attributes(n))
end

function attr_dict(f::Function, n::EzXML.Node)
  LittleDict(f(a.name => n[Symbol(a.name)]) for a in attributes(n))
end

 function stipple_attr(attr)
  js = startswith(attr[1], ':')
  k = js ? attr[1][2:end] : attr[1]
  k = replace(get(REV_DICT, k, k), "__vue-on__" => "v-on:")
  startswith(repr(Symbol(k)), ':') || (k = "var\"$k\"")
  
  v = replace(attr[2], raw"$" => raw"\$")
  v = js ? repr(Symbol(attr[2])) : "\"$v\""
  if js
    v = startswith(v, ":") ? v : "R\"$v\""
  end

  k => v
end
 
function function_parser(tag, attrs, context = @__MODULE__)
  tag_str = replace(String(typeof(tag).parameters[1]), "-" => "__")
  julia_fn = Symbol(replace(String(typeof(tag).parameters[1]), r"^q-" => "", "-" => ""))
  M = if isdefined(Stipple, julia_fn)
    Stipple
  elseif isdefined(StippleUI, julia_fn)
    StippleUI
  elseif isdefined(context, julia_fn)
    context
  else
    nothing
  end

  arg_str = ""
  is_html_tag = false
  if M !== nothing && tag_str != "q__input"
    f = getfield(M, julia_fn)
    attr_names = rstrip.(keys(attrs), '!')
    sigs = method_signatures(methods(f))
    is_html_tag = length(sigs) == 0

    args = String[]
    for sig in sigs
      length(intersect(sig, attr_names)) == length(sig) && (args = sig; break)
    end

    name_dict = LittleDict(zip(attr_names, keys(attrs)))
    arg_str = join([attrs[name_dict[k]] for k in args], ", ")
    for k in args
      delete!(attrs, name_dict[k])
    end

    if is_html_tag
      # then the function (probably) does not support Symbol values for arguments, so revert to adding a '!' to the key
      index = startswith.(values(attrs), '"')
      if ! all(index)
        attrs = LittleDict(startswith(v, '"') ? k => v : "$(k)!" => (startswith(v, 'R') ? v[2:end] : "\"$(v[2:end])\"") for (k, v) in zip(keys(attrs), values(attrs)))
      end
    end
  end

  fn_str = if M === nothing || tag_str == "q__input"
    startswith(tag_str, "q__") ? "quasar(:$(tag_str[4:end]), " : startswith(tag_str, "vue__") ? "vue(:$(tag_str[6:end]), " : "xelem(:$tag_str, "
  else
    julia_fn == :div && (julia_fn = Symbol("Stipple.Html.div"))
    "$julia_fn("
  end
   
  fn_str, arg_str, attrs
end
 
function attr_tostring(attr::Pair)
    "$(attr[1]) = $(attr[2])"
end

function parse_elem(el::EzXML.Node, level = 1)
    iselement(el) || return strip(el.content)
    indent = repeat(' ', level * 4)
    arg_str = ""
    attrs = attr_dict(stipple_attr, el)

    fn_str, arg_str, new_attrs = function_parser(Val(Symbol(el.name)), attrs)

    attr_str = join(attr_tostring.(collect(new_attrs)), ", ")

    children = parse_elem.(nodes(el), level + 1)
    children = children[length.(children) .> 0]
    children_str = join(children, "\n$indent")
 
    no = length(children)
    sep1 = (length(arg_str) + length(attr_str) == 0) ? "" : ", "
    indent2 = no == 0 ? "" : repeat(' ', (level-1) * 4)
    sep2, sep3 = if no == 0
        ("", "")
    elseif no == 1
        ("$sep1\n$indent", "\n$indent2")
    else
        ("$sep1[\n$indent", "\n$indent2]")
    end
 
    sep0 = length(arg_str) > 0 && length(attr_str) > 0 ? ", " : ""
    """$fn_str$arg_str$sep0$attr_str$sep2$children_str$sep3)"""
end

 
function parse_vue_html(html)
  doc_string = replace(html, "@"=>"__vue-on__")
  empty!(EzXML.XML_GLOBAL_ERROR_STACK)
  doc = Logging.with_logger(Logging.SimpleLogger(stdout, Logging.Error)) do
    EzXML.parsehtml(doc_string).root
  end
  # remove the html -> body levels
  replace(parse_elem(first(eachelement(first(eachelement(doc))))), "__vue-on__" => "@")
end

function function_parser(tag::Val{Symbol("q-input")}, attrs, context = @__MODULE__)
  kk = String.(collect(keys(attrs)))
  pos = findfirst(startswith(r"fieldname$|var\"v-model."), kk)
  if pos === nothing
    function_parser(Val(:q__input), attrs)
  else
    haskey(attrs, "label") || (attrs["label"] = "\"\"")
    k = kk[pos]
    v = attrs[k]
    v_symbol = repr(Symbol(strip(v, '"')))
    startswith(v_symbol, ":") && (v = v_symbol)

    k == "fieldname" || delete!(attrs, k)
    attrs["fieldname"] = v

    if k == "var\"v-model.number\""
      function_parser(Val(:numberfield), attrs)
    else
      function_parser(Val(:textfield), attrs)
    end
  end
end

# precompilation ...

doc_string = """
<template>
    <div class="q-pa-md">
    <q-scroll-area style="height: 230px; max-width: 300px;">
        <div class="row no-wrap">
            <div v-for="n in 10" :key="n" style="width: 150px" class="q-pa-sm">
                Lorem @ipsum dolor sit amet consectetur adipisicing elit. Architecto fuga quae veritatis blanditiis sequi id expedita amet esse aspernatur! Iure, doloribus!
            </div>
            <q-btn color=\"primary\" label=\"`Animate to \${position}px`\" @click=\"scroll = true\"></q-btn>
            <q-input hint=\"Please enter some words\" v-on:keyup.enter=\"process = true\" label=\"Input\" v-model=\"input\" class=\"q-my-md\"></q-input>
            <q-input hint=\"Please enter a number\" label=\"Input\" v-model.number=\"numberinput\" class=\"q-my-md\"></q-input>
        </div>
    </q-scroll-area>
    </div>
</template>
""";

parse_vue_html(doc_string)

end