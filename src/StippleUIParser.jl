module StippleUIParser

using PrecompileTools

export parse_vue_html, test_vue_parsing, prettify

using Stipple
using StippleUI
using OrderedCollections

using Genie.Logging
using Genie.Renderer.Html.EzXML

const AT_MASK = "__vue-on__"

# add a method that doesn't interpret ':' as separator for namespace
# when a Symbol is passed as index (instead of an AbstractString)
function Base.getindex(node::EzXML.Node, attr::Symbol)
  str_ptr = ccall(
    (:xmlGetNoNsProp, EzXML.libxml2),
    Cstring,
    (Ptr{Cvoid}, Cstring),
    node.ptr, String(attr)
  )
  str = unsafe_string(str_ptr)
  Libc.free(str_ptr)
  return str
end

function rawrepr(x)
  r = string(x) #repr(x)[2:end-1]
  quotes = if occursin('"', r)
      endswith(r, '"') && (r = r[1:end-1] * "\\\"")
      "\"\"\""
  else
      "\""
  end
  string(occursin('$', r) ? "raw" : "", quotes, r, quotes)
end

function symrepr(x)
  # if x is surrounded by quotes strip quotes
  startswith(x, '"') && endswith(x, '"') && length(x) > 1 && (x = x[2:end-1])

  # if x is already a Symbol representation return x
  startswith(x, ":") || startswith(x, "R\"") && return string(x)

  v_sym = repr(Symbol(x))
  if startswith(v_sym, ":")
    v_sym
  else
    x = rawrepr(x)
    string("R", startswith(x, "raw") ? x[4:end] : x)
  end
end


REV_DICT = Dict(zip(values(StippleUI.API.ATTRIBUTES_MAPPINGS), keys(StippleUI.API.ATTRIBUTES_MAPPINGS)))
const ToV = @static if isdefined(Core, :TypeofVararg) # VERSION >= v"1.7.0-DEV.77"
  # Core.TypeofVararg introduced in https://github.com/JuliaLang/julia/pull/38136
  typeof(Vararg)
else
  # not sure whether this will handle all cases correctly, but tests pass
  UnionAll
end

function method_signature(m::Method)
  body = m.sig
  while hasproperty(body, :body)
    body = body.body
  end
  Tuple[(v, T) for (v, T) in zip(split(m.slot_syms, '\0')[2:end-1], body.types[2:end-1]) if ! (T isa ToV)]
end

function method_signatures(mm::Union{Vector{Method}, Base.MethodList})
  sigs = Vector{Tuple}[]
  for m in mm
    startswith("$(m.module)", "Stipple") || continue
    sig = method_signature(m)
    (length(sig) == 0 || sig[1][1] ∉ ["children", "content"]) && push!(sigs, sig)
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
  k = replace(get(REV_DICT, k, k), AT_MASK => "v-on:")
  startswith(repr(Symbol(k)), ':') || (k = "var\"$k\"")
  
  v = if js
    symrepr(attr[2])
  else
    rawrepr(attr[2])
  end

  k => v
end

const OPENERS = ('(', '{', '[')
const CLOSERS = (')', '}', ']')
const QUOTES = (''', '"')

closer(c) = c == '(' ? ')' : c == '{' ? '}' : c == '[' ? ']' : c


function next_js_expr(s, start_index::Int = 1)
    tracker = Char[]
    escaped = false

    i = start_index
    last_index = lastindex(s)
    while i <= last_index
        c = s[i]
        if length(tracker) > 0 && c == tracker[end] && ! escaped
            pop!(tracker)
            i = nextind(s, i)
            continue
        end
        if isempty(tracker) && (c ∈ (',', ':') || c ∈ CLOSERS)
            return strip(s[start_index:prevind(s, i)]), i
        end
        quoted = length(tracker) > 0 && tracker[end] in QUOTES
        if !quoted && (c in OPENERS || c in QUOTES)
            push!(tracker, closer(c))
        end
        escaped = !escaped && quoted && c == '\\'
        i = nextind(s, i)
    end
    return strip(s[start_index:last_index]), i
end

next_js_expr("function(a, b, ϕ = 'hi') { return this.x }}] and more")

is_jsontext(::JSONText) = true
is_jsontext(s::String) = startswith(s, "js\"")
is_jsontext(x) = false

function parse_js_expr(s; code = true)
    s = strip(s)
    
    s == "" && return nothing
    if s[1] ∈ union('0':'9', '.')
        x = contains(s, r"[.eE]") ? tryparse(Float64, s) : tryparse(Int, s)
        x !== nothing && return x
    end
    s[1] ∈ QUOTES && s[1] == s[end] && return String(s[2:end-1])

    last_index = lastindex(s)
    i = 1
    c = s[i]
    
    if c ∈ OPENERS
        aa = Any[]
        close_char = closer(c)
        while c != close_char && i <= last_index
            k = ""
            if close_char == '}'
                k, i = next_js_expr(s, nextind(s, i))
                length(k) > 1 && k[1] ∈ QUOTES && k[1] == k[end] && (k = k[2:end-1])
            end
            v, i = next_js_expr(s, nextind(s, i))
            k == "" && v == "" && continue
            if close_char == '}'
                k_value = parse_js_expr(k; code)
                k_value isa JSONText && (k_value = k_value.s)
                push!(aa, k => parse_js_expr(v; code))
            else
                push!(aa, parse_js_expr(v; code))
            end    
            c = s[i]
        end

        a_str = ""
        if code
            a_str = if close_char == '}'
                Stipple.join(["$(repr(is_jsontext(a[1]) ? a[1][4:end-1] : repr(a[1])) : a[1])) => $(is_jsontext(a[2]) ? a[2] : repr(a[2]))" for a in aa], ", ")
            else
                Stipple.join([is_jsontext(a) ? a : repr(a) for a in aa], ", ")
            end
        end
        return if close_char == ']'
            code ? "[$a_str]" : aa
        elseif close_char == ')'
            code ? "($a_str)" : tuple(aa...)
        else
            code ? "Dict($a_str)" : Dict(aa...)
        end
    end

    return code ? "js" * repr(s) : JSONText(s)
end

function function_parser(tag, attrs; context = @__MODULE__, flexgrid_parsing = true)
  tag_str = replace(String(typeof(tag).parameters[1]), "-" => "__")
  julia_str = String(typeof(tag).parameters[1])
  julia_fn = Symbol(replace(startswith(julia_str, "q-") ? julia_str[3:end] : julia_str, "-" => ""))
  M = if isdefined(StippleUI, julia_fn)
    StippleUI
  elseif isdefined(Stipple, julia_fn)
    Stipple
  elseif isdefined(context, julia_fn)
    context
  else
    nothing
  end

  # if tag_str == "q__layout"
  #   julia_str = Symbol("StippleUI.layout")
  #   M = StippleUI
  # end

  arg_str = ""
  is_html_tag = false
  f = nothing
  if M !== nothing && tag_str != "q__input"
    f = getfield(M, julia_fn)
    attr_names = rstrip.(keys(attrs), '!')
    sigs = method_signatures(methods(f))
    is_html_tag = length(sigs) == 0

    args = String[]
    type_dict = LittleDict{String, Type}()
    for sig in sigs
      sig_names = getindex.(sig, 1)
      if length(intersect(sig_names, attr_names)) == length(sig)
        type_dict = LittleDict{String, Type}(sig)
        args = sig_names
        break
      end
    end

    # parse flexgrid attributes
    if (!is_html_tag || tag_str in ("div", "col", "row", "cell")) && flexgrid_parsing
      kk = String.(collect(keys(attrs)))
      pos = findfirst(startswith(r":?class$"), kk)
      if pos !== nothing
        k = kk[pos]
        v = attrs[k]
        v_new, removed = remove_class(v, r"^col(-..)?(-(\d+|auto))?$")

        if ! isempty(removed)
          if v_new in ("", "''", "R\"''\"")
            delete!(attrs, k)
          else
            attrs[k] = v_new
          end
          for r in removed
            xx = split(r, '-')
            (length(xx) == 1 || length(xx) == 2 && xx[2][1] ∈ 'a':'z' ) && push!(xx, "0")
            if length(xx) == 2
              attrs[:col] = xx[2]
            else
              attrs[Symbol(xx[2])] = xx[3]
            end
          end
        end
      end
    end

    name_dict = LittleDict(zip(attr_names, keys(attrs)))
    # if variable accepts Symbols but no Strings convert to Symbol
    arg_str = join([!(String <: type_dict[k]) && Symbol <: type_dict[k] ? symrepr(attrs[name_dict[k]]) : attrs[name_dict[k]] for k in args], ", ")
    for k in args
      delete!(attrs, name_dict[k])
    end

    if is_html_tag && julia_fn != :div
      # then the function (probably) does not support Symbol values for arguments, so revert to adding a '!' to the key
      # e.g. `a = :test`, `b = R"myarray[1]"`
      index = startswith.(values(attrs), '"')
      if ! all(index)
        attrs = LittleDict(startswith(v, '"') ? k => v : 
          (endswith("$k", '"') ? string(k[1:end-1], "!\"") : string(k, '!')) => rawrepr(startswith(v, 'R') ? v[3:end-1] : v[2:end])
          for (k, v) in attrs
        )
      end
    end
  end

  fn_str = if M === nothing || tag_str == "q__input"
    startswith(tag_str, "q__") ? "quasar(:$(tag_str[4:end]), " : startswith(tag_str, "vue__") ? "vue(:$(tag_str[6:end]), " : "xelem(:$tag_str, "
  else
    if julia_fn == :div
      julia_fn = :htmldiv
    elseif M == Stipple
      # if a function is defined in both Stipple and context and if they are not identical, prefix it with `Stipple.`
      if isdefined(context, julia_fn) && getfield(context, julia_fn) != f
        julia_fn = Symbol("Stipple.$julia_fn")
      end
    elseif M == StippleUI
      # if a function is defined in both StippleUI and Stipple or context and if they are not identical, prefix it with `StippleUI.`
      if isdefined(Stipple, julia_fn) && getfield(Stipple, julia_fn) != f ||
        isdefined(context, julia_fn) && getfield(context, julia_fn) != f
        julia_fn = Symbol("StippleUI.$julia_fn")
      end
    end
    "$julia_fn("
  end
   
  fn_str, arg_str, attrs
end
 
function attr_to_kwargstring(attr::Pair)
  "$(attr[1]) = $(attr[2])"
end

function attr_to_paramstring(attr::Pair)
  "$(attr[1])=\"$(attr[2])\""
end

function node_to_stipple(el::EzXML.Node, level = 0; @nospecialize(indent::Union{Int, String} = 4), pre::Bool = false, vec_sep::String = ",\n", context = @__MODULE__, flexgrid_parsing = true)
  startlevel = level
  level < 0 && (level = 0) 

  is_el = iselement(el)
  content = if is_el
    ""
  else
    pre ? el.content : strip(el.content)
  end
  
  ! is_el && (length(content) == 0 || content == "\n") && return ""
  
  indent_str = if indent isa Int
    repeat(' ', level * indent::Int)
  else
    repeat(indent::String, level)
  end
 
  ! is_el && return "$indent_str$(rawrepr(content))"

  tag = el.name
  pre = pre || lowercase(tag) == "pre"

  arg_str = ""
  attrs = attr_dict(stipple_attr, el)

  fn_str, arg_str, new_attrs = function_parser(Val(Symbol(el.name)), attrs; context, flexgrid_parsing)

  attr_str = join(attr_to_kwargstring.(collect(new_attrs)), ", ")

  children = node_to_stipple.(nodes(el), startlevel + 1; indent, pre, vec_sep, context, flexgrid_parsing)
  children = children[length.(children) .> 0]
  children_str = join(children, vec_sep)

  no = length(children)
  sep3, sep4 = if no == 0
    "", ""
  elseif no == 1
    "\n", "\n$indent_str"
  else
    "[\n", "\n$indent_str]"
  end
  
  sep1 = length(arg_str) > 0 && length(attr_str) > 0 ? ", " : ""
  sep2 = (length(arg_str) + length(attr_str) == 0) ? "" : ", "
  """$indent_str$fn_str$arg_str$sep1$attr_str$sep2$sep3$children_str$sep4)"""
end

function node_to_html(el::EzXML.Node, level = 0; @nospecialize(indent::Union{Int, String} = 4), pre = false)
  startlevel = level
  level < 0 && (level = 0) 
  indent_str = if indent isa Int
    repeat(' ', level * indent::Int)
  else
    repeat(indent::String, level)
  end

  if ! iselement(el)
    return if el.content == "\n"
      ""
    elseif pre || length(el.content) == 0
      el.content
    else
      "$indent_str$(occursin('\n', el.content) ? replace(strip(el.content), r"\n\s*" =>"\n$indent_str") : strip(el.content))"
    end
  end
  tag = el.name

  attrs = attr_dict(el)
  attr_str = join(attr_to_paramstring.(collect(attrs)), " ")

  pre = tag == "pre"
  childnodes = nodes(el)
  children = node_to_html.(childnodes, startlevel + 1; indent, pre)

  if ! pre
    index = length.(children) .> 0
    all(index) || (children = children[index])
  end
  children_str = join(children, "\n")
  no = length(children)

  if no > 0 && pre && startswith(children_str, "\n")
    children_str = children_str[2:end]
  end

  last_child_is_el = length(children) > 0 && iselement(childnodes[end])
  single_line = no == 0 || pre && ! occursin('\n', children_str)
  sep1 = length(attr_str) == 0 ? "" : " "
  sep2 = single_line ? "" : "\n"
  sep3 = if no == 0
    ""
  else
    if pre && ! last_child_is_el
      endswith(children_str, "\n") ? indent_str : ""
    else
      "\n$indent_str"
    end
  end
  end_tag = tag == "br" ? "" : "</$tag>"
  """$indent_str<$tag$sep1$attr_str>$sep2$children_str$sep3$end_tag"""
end
 
"""
    parse_vue_html(html, level = 0; indent::Union{String, Int} = 4, vec_sep::String = ",\n", context = @__MODULE__)

Parse html code to Julia/StippleUI code with automatic line breaks and indenting. Indenting can be determined by
- `level: starting level for formatting; negative values are allowed, negative levels are not indented
- `indent`: either Integer for number of ' ' characters per level or a string value
- `vec_sep`: separator in array listings, reasonable values are `",\\n"`, `"\\n\\n"`, `",\\n\\n"`
- `context`: context for evaluation
"""
function parse_vue_html(html; level::Integer = 0, indent::Union{String, Int} = 4, vec_sep::String = ",\n", context = @__MODULE__, flexgrid_parsing = true)
  startlevel = level
  level < 0 && (level = 0)

  html_string = ""
  root = if startswith(html, r"\s*<html(\s|>)"i)
    :html
  elseif startswith(html, r"\s*<body(\s|>)"i)
    :body
  elseif startswith(html, r"\s*<head(\s|>)"i)
    :head
  else
    html_string = replace("<body>$html</body>", "@" => AT_MASK)
    root = :no_root
  end

  indent_str = if indent isa Int
    repeat(' ', level * indent::Int)
  else
    repeat(indent::String, level)
  end

  html_string = replace(html, "@" => AT_MASK)
  empty!(EzXML.XML_GLOBAL_ERROR_STACK)
  root_node = Logging.with_logger(Logging.SimpleLogger(stdout, Logging.Error)) do
    EzXML.parsehtml(html_string).root
  end
  # remove the html -> body levels

  if root == :html
    node_to_stipple(root_node, startlevel; indent, vec_sep, context, flexgrid_parsing)
  else
    # remove the html / body levels
    children = nodes(root == :no_root ? root_node.firstelement : root_node)
    is_single = length(children) <= 1
    children_str = node_to_stipple.(children, is_single ? startlevel : startlevel + 1; indent, vec_sep, context, flexgrid_parsing)
    replace(is_single ? children_str[1] : "$indent_str[\n$(join(filter(!isempty, children_str), vec_sep))$indent_str\n]", AT_MASK => "@")
  end |> ParsedHTMLString
end

"""
    prettify(html::AbstractString; level::Int = 0, indent::Union{String, Int} = 4)

Format html code with automatic line breaks and indenting. Indenting can be determined by
- level: starting level for formatting; negative values are allowed, negative levels are not indented
- indent: either Integer for number of ' ' characters per level or a string value
"""
function prettify(html::AbstractString; level::Int = 0, indent::Union{String, Int} = 4)
  startlevel = level
  level < 0 && (level = 0)
  
  html_string = ""
  root = if startswith(html, r"\s*<html(\s|>)"i)
    :html
  elseif startswith(html, r"\s*<body(\s|>)"i)
    :body
  elseif startswith(html, r"\s*<head(\s|>)"i)
    :head
  else
    html_string = replace("<body>$html</body>", "@" => AT_MASK)
    root = :no_root
  end
  
  length(html_string) == 0 && (html_string = replace(html, "@" => AT_MASK))
  empty!(EzXML.XML_GLOBAL_ERROR_STACK)
  root_node = Logging.with_logger(Logging.SimpleLogger(stdout, Logging.Error)) do
    EzXML.parsehtml(html_string).root
  end
  
  if root == :html
    node_to_html(root_node, startlevel; indent)
  else
    # remove the html / body levels
    children = nodes(root == :no_root ? root_node.firstelement : root_node)
    replace(join(node_to_html.(children, startlevel; indent), "\n"), AT_MASK => "@")
  end |> ParsedHTMLString
end

function prettify(el::EzXML.Node; level::Int = 0, indent::Union{String, Int} = 4)
  replace(node_to_html(el, level; indent), AT_MASK => "@")
end

prettify(doc::EzXML.Document; level::Int = 0, indent::Union{String, Int} = 4) = prettify(doc.root; level, indent)

prettify(v::Vector; level::Int = 0, indent::Union{String, Int} = 4) = prettify(join(v); level, indent)

function function_parser(tag::Val{Symbol("q-input")}, attrs; context = @__MODULE__, flexgrid_parsing = true)
  kk = String.(collect(keys(attrs)))
  pos = findfirst(startswith(r"fieldname$|var\"v-model."), kk)
  if pos === nothing
    function_parser(Val(:q__input), attrs; context, flexgrid_parsing)
  else
    haskey(attrs, "label") || (attrs["label"] = "\"\"")
    k = kk[pos]
    v = attrs[k]
    k == "fieldname" || delete!(attrs, k)
    attrs["fieldname"] = v

    if k == "var\"v-model.number\""
      function_parser(Val(:numberfield), attrs; context, flexgrid_parsing)
    else
      function_parser(Val(:textfield), attrs; context, flexgrid_parsing)
    end
  end
end

function contains_class(class::String, subclass::Union{String, Regex})
  # removes any quotation ("<...>", R"<...>") and stores the captured parts for concatentation at the end
  m = match(r"^(R?\"+)?(.*?)(\"+)?$", class)
  class = m.captures[2]
  isreactive = m.captures[1] !== nothing && contains(m.captures[1], "R")
  
  classes = isreactive ? split(class, r"\s*\+\s*") : [class]
  for (n, class) in enumerate(classes)
    isreactive && first(class) != ''' && continue
    # only evaluate explicit terms when they are at the beginning or when their first character is a whitespace
    n > 1 && length(class) > 1 && !contains(class[2:2], r"\s") && continue
    cc = split(strip(class, '''))
    for c in cc
      (subclass isa String ? subclass == c : contains(c, subclass)) && return true
    end
  end
  false
end

function remove_class(class::String, subclass::Union{String, Regex})
  removed = String[]
  # removes any quotation ("<...>", R"<...>") and stores the captured parts for concatentation at the end
  m = match(r"^(R?\"+)?(.*?)(\"+)?$", class)
  class = m.captures[2]
  isquoted = m.captures[1] !== nothing

  isreactive = m.captures[1] !== nothing && contains(m.captures[1], "R")
  classes = isreactive ? split(class, r"\s*\+\s*") : [class]
  for n in length(classes):-1:1
    class = classes[n]
    isreactive && first(class) != ''' && continue
    # only evaluate explicit terms when they are at the beginning or when their first character is a whitespace
    n > 1 && length(class) > 1 && !contains(class[2:2], r"\s") && continue
    cc = split(strip(class, '''))
    remove_outer = false
    for i in length(cc):-1:1
      remove = false
      c = cc[i]
      if subclass isa String ? subclass == c : contains(c, subclass)
        pushfirst!(removed, c) # because of inverted
        deleteat!(cc, i)
        remove_outer = remove = true
      end
    end

    if remove_outer
      classes[n] = join(cc, ' ')
      first(class) == ''' && (classes[n] =  "' " * classes[n] * ''')
    end
    classes[n] in ("", "''", "' '") && deleteat!(classes, n)
  end

  c = join(classes, " + ")
  c == "" && isreactive && (c = "''")
  
  if isquoted
    c = m.captures[1] * c * m.captures[3]
    if c[1] == 'R'
      x = repr(Symbol(c[3:end-1]))
      startswith(x, ":") && (c = x)
    end
  end
  
  return c, removed
end

function function_parser(tag::Val{:div}, attrs, context = @__MODULE__, flexgrid_parsing = true)
  kk = String.(collect(keys(attrs)))
  pos = findfirst(startswith(r":?class$"), kk)
  if pos === nothing
    function_parser(Val(:htmldiv), attrs; context, flexgrid_parsing)
  else
    k = kk[pos]
    v = attrs[k]
    if k == "class"
      for c in ("row", "column", r"^col(-..)?(-(\d+|auto))?$")
        tagname = c isa Regex ? :cell : Symbol(c)
        v_new, removed = remove_class(v, c)
        isempty(removed) && continue

        if c isa Regex && ! isempty(removed)
          # if there is at least one col element check if "st-col" is part of the class
          v_new, removed = remove_class(v, "st-col")
          isempty(removed) && continue
          # remove "col" from the class
          v_new, removed = remove_class(v_new, "col")
        end

        if v_new[2:end-1] in  ("", "''")
          delete!(attrs, k)
        else
          attrs[k] = v_new
        end

        return function_parser(Val(tagname), attrs; context, flexgrid_parsing)
      end
    end
    function_parser(Val(:htmldiv), attrs; context, flexgrid_parsing)
  end
end

"""
    test_vue_parsing(html_string; prettify::Bool = true, level = 0, indent = 4, context = @__MODULE__)

Parse html code with automatic line breaks and indentingto Julia/StippleUI code, execute the code and prettify the result.
Indenting can be determined by
- `level`: starting level for formatting; negative values are allowed, negative levels are not indented
- `indent`: either Integer for number of ' ' characters per level or a string value
- `context`: context for evaluation
"""
function test_vue_parsing(html_string; prettify::Bool = true, level = 0, indent = 4, context = @__MODULE__, flexgrid_parsing = true)
  println("\nOriginal HTML string:")
  printstyled(html_string, "\n\n", color = :light_red)
  
  julia_code = parse_vue_html(html_string; level, indent, context, flexgrid_parsing)

  println("Julia code:")
  printstyled(julia_code, "\n\n", color = :blue)

  println("Produced HTML:")
  new_html = Core.eval(context, Meta.parse(julia_code))
  printstyled(prettify ? StippleUIParser.prettify(new_html; level, indent) : new_html, "\n", color = :green)
end

# precompilation ...

@setup_workload begin
  # Putting some things in `setup` can reduce the size of the
  # precompile file and potentially make loading faster.
  using StippleUI.API

  html_string = """
  <template>
      <div class="q-pa-md">
      <q-scroll-area style="height: 230px; max-width: 300px;">
          <div class="row no-wrap">
              <div v-for="n in 10" :key="n" style="width: 150px" class="q-pa-sm">
                  Lorem @ipsum dolor sit amet consectetur adipisicing elit.
              </div>
              <q-btn color=\"primary\" label=\"`Animate to \${position}px`\" @click=\"scroll = true\"></q-btn>
              <q-input hint=\"Please enter some words\" v-on:keyup.enter=\"process = true\" label=\"Input\" v-model=\"input\"></q-input>
              <q-input hint=\"Please enter a number\" label=\"Input\" v-model.number=\"numberinput\" class=\"q-my-md\"></q-input>
          </div>
      </q-scroll-area>
      </div>
  </template>
  """
  @compile_workload begin
      # all calls in this block will be precompiled, regardless of whether
      # they belong to your package or not (on Julia 1.8 and higher)
      redirect_stdout(devnull) do
        test_vue_parsing(html_string)
      end
  end
end

end