module Table

using Revise

import DataFrames, JSON
import Genie, Stipple
import Genie.Renderer.Html: HTMLString, normal_element, table, template_

using Stipple

export Column, DataTablePagination, DataTableOptions, DataTable

Genie.Renderer.Html.register_normal_element("q__table", context = @__MODULE__)

const ID = "__id"

#===#

Base.@kwdef mutable struct Column
  name::String
  required::Bool = false
  label::String = name
  align::Symbol = :left
  field::String = name
  sortable::Bool = true
end

function Column(name::String; args...)
  Column(name = name; args...)
end

function Base.Symbol(v::Vector{Column}) :: Vector{Symbol}
  [Symbol(c.name) for c in v]
end

Base.@kwdef mutable struct DataTablePagination
  sort_by::Symbol = :desc
  descending::Bool = false
  page::Int = 1
  rows_per_page::Int = 10
end

Base.@kwdef mutable struct DataTableOptions
  addid::Bool = false
  idcolumn::String = "ID"
  columns::Union{Vector{Column},Nothing} = nothing
end

Base.@kwdef mutable struct DataTable{T<:DataFrames.DataFrame}
  data::T = DataFrames.DataFrame()
  opts::DataTableOptions = DataTableOptions()
end

function DataTable(data::T) where {T<:DataFrames.DataFrame}
  DataTable(data, DataTableOptions())
end

#===#

function active_columns(t::T)::Vector{Column} where {T<:DataTable}
  t.opts.columns !== nothing ? t.opts.columns : [Column(string(name)) for name in DataFrames.names(t.data)]
end

function columns(t::T)::Vector{Column} where {T<:DataTable}
  columns = active_columns(t) |> copy

  if t.opts.addid
    pushfirst!(columns, Column(t.opts.idcolumn, true, t.opts.idcolumn, :right, t.opts.idcolumn, true))
  end

  columns
end

function rows(t::T)::Vector{Dict{String,Any}} where {T<:DataTable}
  count = 0
  rows = []

  for row in DataFrames.eachrow(t.data)
    r = Dict()

    if t.opts.addid
      r[t.opts.idcolumn] = (count += 1)
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

function Genie.Renderer.Html.table( fieldname::Symbol,
                                    args...;
                                    rowkey::String = ID,
                                    title::String = "",
                                    datakey::String = "data_$fieldname",
                                    columnskey::String = "columns_$fieldname",
                                    selected::Union{Symbol,Nothing} = nothing,
                                    hideheader::Bool = false,
                                    hidebottom::Bool = false,
                                    pagination::Union{Symbol,Nothing} = nothing,
                                    separator::Union{String,Symbol} = :none,
                                    loading::Union{Symbol,Bool} = false,
                                    kwargs...) :: String

  k = (Symbol(":data"), Symbol(":columns"), Symbol("row-key"), :separator)
  v = Any["$fieldname.$datakey", "$fieldname.$columnskey", rowkey, separator]

  if selected !== nothing
    k = (k..., Symbol(":selected.sync"))
    push!(v, selected)
  end

  if hideheader
    k = (k..., Symbol("hide-header"))
    push!(v, true)
  end

  if hidebottom
    k = (k..., Symbol("hide-bottom"))
    push!(v, true)
  end

  if pagination !== nothing
    k = (k..., Symbol(":pagination.sync"))
    push!(v, pagination)
  end

  if (isa(loading, Bool) && loading) || (isa(loading, Symbol))
    k = (k..., (isa(loading, Symbol) ? Symbol(":loading") : :loading)))
    push!(v, loading)
  end

  template_() do
    q__table(args...; kwargs..., NamedTuple{k}(v)...)
  end
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

end