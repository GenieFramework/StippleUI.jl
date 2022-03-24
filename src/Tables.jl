module Tables

import DataFrames
using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, table, template, register_normal_element

export Column, DataTablePagination, DataTableOptions, DataTable

register_normal_element("q__table", context = @__MODULE__)

const ID = "__id"

#===#

struct2dict(s::T) where T = Dict{Symbol, Any}(zip(fieldnames(T), getfield.(Ref(s), fieldnames(T))))

Base.@kwdef mutable struct Column
  name::String
  required::Bool = false
  label::String = name
  align::Symbol = :left
  field::String = name
  sortable::Bool = true
end

"""
    Column(name::String, args...)

----------
# Examples
----------

```julia-repl
julia> Column("x2", align = :right)
```

----------
# Arguments
----------

* `required::Bool` - if we use `visiblecolumns`, this col will always be visible
* `label::String` - label for header
* `align::Symbol` - alignment for cell
* `field::String` - row Object property to determine value for this column ex. `name`
* `sortable::Bool` - tell `table` you want this column sortable

"""
function Column(name::String; args...)
  Column(name = name; args...)
end

function Base.Symbol(v::Vector{Column}) :: Vector{Symbol}
  [Symbol(c.name) for c in v]
end

"""
    DataTablePagination(sort_by::Symbol, descending::Bool, page::Int, row_per_page::Int)
    
----------
# Examples
----------

```julia-repl
julia> DataTablePagination(rows_per_page=50)
```
"""
Base.@kwdef mutable struct DataTablePagination
  sort_by::Symbol = :desc
  descending::Bool = false
  page::Int = 1
  rows_per_page::Int = 10
end

"""
    DataTableOptions(addid::Bool, idcolumn::String, columns::Union{Vector{Column},Nothing}, columnspecs::Dict{Union{String, Regex}, Dict{Symbol, Any}})
    
----------
# Examples
----------

```julia-repl
julia> DataTableOptions(columns = [Column("x1"), Column("x2", align = :right)])
```

### Columnspecs

Usage for formating columns

```julia-repl
julia> import Stipple.opts
julia> df = DataFrame(a = sin.(-π:π/10:π), b = cos.(-π:π/10:π), c = string.(rand(21)))
julia> dt = DataTable(df)
julia> dt.opts.columnspecs[r"^(a|b)\$"] = opts(format = jsfunction(raw"(val, row) => `\${100*val.toFixed(3)}%`"))
julia> model.table[] = dt 
```
"""
Base.@kwdef mutable struct DataTableOptions
  addid::Bool = false
  idcolumn::String = "ID"
  columns::Union{Vector{Column},Nothing} = nothing
  columnspecs::Dict{Union{String, Regex}, Dict{Symbol, Any}} = Dict()
end


Base.@kwdef mutable struct DataTable{T<:DataFrames.DataFrame}
  data::T = DataFrames.DataFrame()
  opts::DataTableOptions = DataTableOptions()
end


"""
    DataTable(data::T<:DataFrames.DataFrame, opts::DataTableOptions)
    
----------
# Examples
----------

```julia-repl
julia> df = DataFrame(a = sin.(-π:π/10:π), b = cos.(-π:π/10:π), c = string.(rand(21)))
julia> dt = DataTable(df)
```
"""
function DataTable(data::T) where {T<:DataFrames.DataFrame}
  DataTable(data, DataTableOptions())
end

#===#

function active_columns(t::T)::Vector{Column} where {T<:DataTable}
  t.opts.columns !== nothing ? t.opts.columns : [Column(string(name)) for name in DataFrames.names(t.data)]
end

"""
    columns(t::T)::Vector{Column} where {T<:DataTable}

```julia-repl
julia> columns = [Column("x1"), Column("x2", align = :right)]
```
"""
function columns(t::T)::Vector{<:Union{Column, Dict}} where {T<:DataTable}
  columns = active_columns(t) |> copy

  if t.opts.addid
    pushfirst!(columns, Column(t.opts.idcolumn, true, t.opts.idcolumn, :right, t.opts.idcolumn, true))
  end

  if isempty(t.opts.columnspecs)
    columns
  else
    coldicts = Dict{Symbol, Any}[]
    for col in columns
      coldict = struct2dict(col)
      for (k, v) in t.opts.columnspecs
        occursin(k isa String ? Regex("^$k\$") : k, col.name) && merge!(coldict, v)
      end
      push!(coldicts, coldict)
    end
    coldicts
  end
end

function rows(t::T)::Vector{Dict{String,Any}} where {T<:DataTable}
  rows = []

  for (count, row) in enumerate(DataFrames.eachrow(t.data))
    r = Dict()

    if t.opts.addid
      r[t.opts.idcolumn] = count
    end

    r[ID] = count
    for column in active_columns(t)
      r[column.name] = row[Symbol(column.name)]
    end

    push!(rows, r)
  end

  rows
end

function data(t::T, fieldname::Symbol; datakey = "data_$fieldname", columnskey = "columns_$fieldname")::Dict{String,Any} where {T<:DataTable}
  Dict(
    columnskey  => columns(t),
    datakey     => rows(t)
  )
end

"""
    table(fieldnmae::Symbol, args...; kwargs...)


----------
# Examples
----------

### Model

```julia-repl
julia> @reactive mutable struct TableModel <: ReactiveModel
          data::R{DataTable} = DataTable(DataFrame(rand(100000,2), ["x1", "x2"]), DataTableOptions(columns = [Column("x1"), Column("x2", align = :right)]))
          data_pagination::DataTablePagination = DataTablePagination(rows_per_page=50)
       end
```

### View
```julia-repl
julia> table(title="Random numbers", :data; pagination=:data_pagination, style="height: 350px;") 
```

"""
function table( fieldname::Symbol,
                                    args...;
                                    rowkey::String = ID,
                                    title::String = "",
                                    datakey::String = "data_$fieldname",
                                    columnskey::String = "columns_$fieldname",
                                    kwargs...) :: String

  q__table(args...; kw(
    [Symbol(":data") => "$fieldname.$datakey", Symbol(":columns") => "$fieldname.$columnskey", Symbol("row-key") => rowkey,
    :fieldname => fieldname, kwargs...])...)
end

#===#

function Stipple.render(t::T, fieldname::Union{Symbol,Nothing} = nothing) where {T<:DataTable}
  data(t, fieldname)
end

function Stipple.render(dtp::DataTablePagination, fieldname::Union{Symbol,Nothing} = nothing)
  Dict(:sortBy => dtp.sort_by, :descending => dtp.descending, :page => dtp.page, :rowsPerPage => dtp.rows_per_page)
end

#===#

function Stipple.watch(vue_app_name::String, fieldtype::R{T}, fieldname::Symbol, channel::String, model::M)::String where {M<:ReactiveModel,T<:DataTable}
  string(vue_app_name, raw".\$watch('", fieldname, "', function(newVal, oldVal){

  });\n\n")
end

#===#

function Base.parse(::Type{DataTablePagination}, d::Dict{String,Any})
  dtp = DataTablePagination()

  dtp.sort_by = get!(d, "sortBy", "desc") |> Symbol
  dtp.page = get!(d, "page", 1)
  dtp.descending = get!(d, "descending", false)
  dtp.rows_per_page = get!(d, "rowsPerPage", 10)

  dtp
end

function Base.parse(::Type{DataTable}, ::Dict{String,Any})
  # todo: add support
end

function Base.parse(::Type{DataTable{DataFrames.DataFrame}}, ::Dict{String,Any})
  # error("Not implemented") # todo implement parser
end

end
