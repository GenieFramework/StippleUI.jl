module Tables

import Tables as TablesInterface
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
    DataTablePagination(sort_by::Symbol, descending::Bool, page::Int, rows_per_page::Int)

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
  rows_number::Union{Int,Nothing} = nothing
  _filter::AbstractString = "" # keep track of filter value for improving performance
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

or

julia> using TypedTables
julia> t = Table(a = [1, 2, 3], b = [2.0, 4.0, 6.0])
julia> dt = DataTable(t)

or

julia> using Tables
julia> Tables.table([1 2 3; 3 4 5], header = ["a", "b", "c"])
julia> dt = DataTable(t1)
```
"""
function DataTable(data::T) where {T}
  DataTable{T}(data, DataTableOptions())
end

function DataTable{T}() where {T}
  DataTable{T}(T(), DataTableOptions())
end

#===#

function label_clean(input)
  uppercasefirst(replace(string(input), '_'=>' '))
end

function active_columns(t::T)::Vector{Column} where {T<:DataTable}
  t.opts.columns !== nothing ?
    t.opts.columns :
      [Column(string(name), sortable = true, label = label_clean(name)) for name in TablesInterface.columnnames(t.data)]
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

  for (count, row) in enumerate(TablesInterface.rows(t.data))
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

function data(t::T; datakey = "rows", columnskey = "columns")::Dict{String,Any} where {T<:DataTable}
  Dict(
    columnskey  => columns(t),
    datakey     => rows(t),
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
julia> table(:data; pagination=:data_pagination, style="height: 350px;", title="Random numbers")
```

"""
function table( fieldname::Symbol,
                args...;
                rowkey::String = ID,
                datakey::String = "$fieldname.rows",
                columnskey::String = "$fieldname.columns",
                filter::Union{Symbol,String,Nothing} = nothing,
                paginationsync::Union{Symbol,String,Nothing} = nothing,
                kwargs...) :: ParsedHTMLString

  if filter !== nothing && paginationsync !== nothing # by convention, assume paginationsync is used only for server side filtering
    filter_input = [ParsedHTMLString("""
    <template v-slot:top-right>
      <q-input dense debounce="300" v-model="$filter" placeholder="Search">
        <template v-slot:append>
          <q-icon name="search" />
        </template>
      </q-input>
    </template>
    """)]
    args = [args..., filter_input]
  end

  q__table(args...;
    kw([
      Symbol(":rows") => "$datakey",
      Symbol(":columns") => "$columnskey",
      Symbol("row-key") => rowkey,
      :fieldname => fieldname,
      (filter === nothing ? [] : [:filter => filter])...,
      (paginationsync === nothing ? [] : [:paginationsync => paginationsync])...,
      kwargs...
    ])...
  )
end

#===#

function Stipple.render(t::T) where {T<:DataTable}
  data(t)
end

function Stipple.render(dtp::DataTablePagination)
  response = Dict(:sortBy => dtp.sort_by, :descending => dtp.descending, :page => dtp.page, :rowsPerPage => dtp.rows_per_page)
  dtp.rows_number !== nothing && setindex!(response, dtp.rows_number, :rowsNumber)

  response
end

# function to autogenerate entries for js_mounted to make Tables from Quasar1 compatible with tables from Quasar2
# Background: the field 'data' has been renamed to 'rows' in Quasar 2
# This function autogenerates entries that set the 'data' field of tables to the 'rows' field. As Vue3's mechanism
# for watchers relies on getter and setter functions any get or set operation on 'data' will be reflected in rows
# and the respective watchers will be triggered.
function Stipple.js_created_auto(::M) where M<:ReactiveModel
  io = IOBuffer()
  for (fieldname, fieldtype) in zip(fieldnames(M), fieldtypes(M))
    if fieldtype <: DataTable || fieldtype <: Reactive{<:DataTable}
      print(io, "\nthis.$fieldname.data = this.$fieldname.rows")
    end
  end
  String(take!(io))
end

function Stipple.js_watch_auto(::M) where M<:ReactiveModel
  [fieldname => "function() {this.$fieldname.data = this.$fieldname.rows}"
    for (fieldname, fieldtype) in zip(fieldnames(M), fieldtypes(M))
    if fieldtype <: DataTable || fieldtype <: Reactive{<:DataTable}
  ]
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

function DataTableOptions(data::T) where T
  dto = DataTableOptions()
  dto.columns = [Column(string(name), sortable = true, label = label_clean(name)) for name in TablesInterface.columnnames(data)]

  dto
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

```julia
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

```julia
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

#=== event handlers ===#

export process_request

function process_request(data, datatable::DataTable, pagination::DataTablePagination, filter::AbstractString = "")
  event = params(:payload, nothing)

  if event !== nothing &&
    isa(get(event, "event", false), AbstractDict) &&
      isa(get(event["event"], "name", false), AbstractString) &&
        event["event"]["name"] == "request"
    event = event["event"]["event"]["pagination"]
  else
    event = Dict()
    event["sortBy"] = pagination.sort_by
    event["descending"] = pagination.descending
    event["page"] = pagination.page
    event["rowsPerPage"] = pagination.rows_per_page
  end

  event["rowsPerPage"] == 0 && (event["rowsPerPage"] = TablesInterface.rowcount(data)) # when Quasar sends 0, that means all rows

  if filter !== pagination._filter || filter !== ""
    pagination._filter = filter
    collector = []
    counter = 0
    for row in eachrow(data)
      counter += 1
      if sum(occursin.(filter, string.(Array(row)))) > 0
        push!(collector, counter)
      end
    end

    if ! isempty(collector)
      fd = data[collector, :]
      pagination.rows_number = length(collector)
    else
      fd = data[!, :]
    end
  else
    fd = data[!, :]
  end

  if event["sortBy"] === nothing
    event["sortBy"] = "desc"
    sort!(fd)
  elseif event["sortBy"] in names(fd)
    sort!(fd, event["sortBy"], rev = event["descending"])
  end

  start_row = (event["page"] - 1) * event["rowsPerPage"] + 1
  end_row = event["page"] * event["rowsPerPage"]

  datatable = typeof(datatable)(fd[(start_row <= pagination.rows_number ? start_row : pagination.rows_number) : (end_row <= pagination.rows_number ? end_row : pagination.rows_number), :], datatable.opts)
  pagination = typeof(pagination)(rows_per_page = event["rowsPerPage"], rows_number = pagination.rows_number, page = event["page"], sort_by = event["sortBy"], descending = event["descending"], _filter = pagination._filter)

  return (data = fd, datatable = datatable, pagination = pagination)
end

end
