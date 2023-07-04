module QTables

import Tables
using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, table, template, register_normal_element

export Column, DataTablePagination, DataTableOptions, DataTable, DataTableSelection, DataTableWithSelection, rowselection, selectrows!

register_normal_element("q__table", context = @__MODULE__)

const ID = "__id"
const DataTableSelection = Vector{Dict{String, Any}}

struct2dict(s::T) where T = Dict{Symbol, Any}(zip(fieldnames(T), getfield.(Ref(s), fieldnames(T))))

#===#

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

function Column(names::Vector{String}) :: Vector{Column}
  Column[Column(name) for name in names]
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


mutable struct DataTable{T}
  data::T
  opts::DataTableOptions
end

"""
    DataTable(data::T, opts::DataTableOptions)

----------
# Examples
----------

```julia-repl
julia> df = DataFrame(a = sin.(-π:π/10:π), b = cos.(-π:π/10:π), c = string.(rand(21)))
julia> dt = DataTable(df)
```
"""
function DataTable(data::T) where {T}
  DataTable{T}(data, DataTableOptions())
end

function DataTable{T}() where {T}
  DataTable{T}(T(), DataTableOptions())
end

# function DataTableWithSelection() where {T}
#   DataTable{T}(T(), DataTableOptions())
# end

#===#

function active_columns(t::T)::Vector{Column} where {T<:DataTable}
  t.opts.columns !== nothing ? t.opts.columns : [Column(string(name)) for name in Tables.columnnames(t.data)]
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

  for (count, row) in enumerate(Tables.rows(t.data))
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

function data(t::T; datakey = "data", columnskey = "columns")::Dict{String,Any} where {T<:DataTable}
  Dict(
    columnskey  => columns(t),
    datakey     => rows(t)
  )
end

"""
    table(fieldname::Symbol, args...; kwargs...)


----------
# Examples
----------

### Model

```julia-repl
julia> @vars TableModel begin
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
                                    datakey::String = "$fieldname.data",
                                    columnskey::String = "$fieldname.columns",
                                    kwargs...) :: ParsedHTMLString

  q__table(args...; kw(
    [Symbol(":data") => "$datakey", Symbol(":columns") => "$columnskey", Symbol("row-key") => rowkey,
    :fieldname => fieldname, kwargs...])...)
end

#===#

function Stipple.render(t::T) where {T<:DataTable}
  data(t)
end

function Stipple.render(dtp::DataTablePagination)
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

function DataTableOptions(d::AbstractDict)
  DataTableOptions(d["addid"], d["idcolumn"], d["columns"], d["columnspecs"])
end

mutable struct DataTableWithSelection
  var""::R{DataTable}
  _pagination::R{DataTablePagination}
  _selection::R{DataTableSelection}
end

function DataTableWithSelection(data::T) where {T}
  dt = DataTable{T}(data, DataTableOptions())
  DataTableWithSelection(dt,  DataTablePagination(), DataTableSelection())
end

Base.getindex(dt::DataTable, args...) = DataTable(dt.data[args...], dt.opts)

Base.getindex(dt::DataTable, row::Int, col) = DataTable(dt.data[[row], col], dt.opts)
Base.getindex(dt::DataTable, row, col::Int) = DataTable(dt.data[row, col::Int], dt.opts)
Base.getindex(dt::DataTable, row::Int, col::Int) = DataTable(dt.data[[row], [col]], dt.opts)


"""
    rowselection(dt::DataTable, rows, cols = Colon(), idcolumn = dt.opts.addid ? dt.opts.idcolumn : "__id")

Build a table selection based on row numbers.

Standard behavior of Quasar is to include all columns in the selection.

For large tables it might be sufficient to include only the index, when no other use of the selection value is made.
This is achieved by setting `cols` to `nothing`

```
rowselection(dt, 3)
rowselection(dt, 2:5)
rowselection(dt, [2, 4, 7])
rowselection(dt, :, nothing)
```

"""
function rowselection(dt::DataTable, rows, cols = Colon(), idcolumn = dt.opts.addid ? dt.opts.idcolumn : "__id")
  if isnothing(cols)
      [Dict{String, Any}(union([idcolumn, "__id"]) .=> row) for row in (rows == Colon() ? (1:nrow(dt.data)) : rows)]
  else
      dd = Stipple.render(dt[rows, cols])["data"]
      setindex!.(dd, rows, "__id")
      dt.opts.addid && setindex!.(dd, rows, dt.opts.idcolumn)
      dd |> Vector{Dict{String, Any}}
  end
end

"""
    rowselection(dt::DataTable, idcolumn::Union{String, Symbol}, values, cols = Colon())

Build a table selection based on an index and a value / list of values.
```
rowselection(dt, "a", [1, 3])
rowselection(dt, "a", 2:9)
```
"""
function rowselection(dt::DataTable, idcolumn::Union{String, Symbol}, values, cols = Colon())
    vals = values isa AbstractString ? [values] : [values...]
    rows = findall(x -> x ∈ vals, dt.data[:, idcolumn])
    rowselection(dt, rows, cols)
end

"""
    rowselection(dt::DataTable, idcolumn::Union{String, Symbol}, f::Function, cols = Colon())

Build a table selection based on a function.
```
rowselection(dt, "a", iseven)
rowselection(dt, "a", x -> x > 3)
```
"""
function rowselection(dt::DataTable, idcolumn::Union{String, Symbol}, f::Function, cols = Colon())
    rows = findall(f, dt.data[:, idcolumn])
    rowselection(dt, rows, cols)
end


"""
    rowselection(dt::DataTable, idcolumn::Union{String, Symbol}, regex::Regex, cols = Colon())

Build a table selection based on a Regex.
```
rowselection(t, "b", r"hello|World")
```
"""
function rowselection(dt::DataTable, idcolumn::Union{String, Symbol}, regex::Regex, cols = Colon())
    rows = findall(x -> occursin(regex, x), dt.data[:, idcolumn])
    rowselection(dt, rows, cols)
end

"""
    selectrows!(model::ReactiveModel, tablefield::Symbol, selectionfield::Symbol = Symbol(tablefield, "_selection"), args...)
    selectrows!(dt::R{<:DataTable}, dt_selection::R, args...)

Select table rows of a model based on selection criteria. More information on selection syntax can be found in `rowselection`

```
@vars TableDemo begin
    @mixin table::TableWithPaginationSelection
end

model = init(TableDemo)
model.table[] = DataTable(DataFrame(a = [1, 2, 4, 6, 8, 10], b = ["Hello", "world", ",", "hello", "sun", "!"]))

selectrows!(model, :table, [1, 2, 6]) # assumes the existence of a field `:table_selection`
selectrows!(model.table, model.table_selection, "b", r"hello|World"i)
selectrows!(model, :table, :table_selection, "a", iseven)
```
"""
function selectrows!(dt::R{<:DataTable}, dt_selection::R, args...)
  dt_selection[] = rowselection(Stipple.Observables.to_value(dt), args...)
end

function selectrows!(model::ReactiveModel, tablefield::Symbol, selectionfield::Symbol, args...)
  getfield(model, selectionfield)[] =
    rowselection(Stipple.Observables.to_value(getfield(model, tablefield)), args...)
end

selectrows!(model::ReactiveModel, tablefield::Symbol, args...) = selectrows!(model, tablefield, Symbol(tablefield, "_selection"), args...)

end
