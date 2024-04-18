module StippleUIDataFramesExt

@static if isdefined(Base, :get_extension)
  using DataFrames
  using StippleUI
  using StippleUI.Stipple
end

function StippleUI.Tables.DataTable()
  DataTable(DataFrames.DataFrame())
end

function StippleUI.DataTableWithSelection()
  DataTableWithSelection(DataTable(),  DataTablePagination(), DataTableSelection())
end

function Stipple.convertvalue(target::Stipple.R{<:DataTable{DataFrames.DataFrame}}, d::AbstractDict)
  df = Stipple.stipple_parse(DataFrames.DataFrame, d[StippleUI.Tables.DATAKEY])
  oldnames = names(target.data)
  newnames = names(df)
  idcolumns = ["__id"]
  target.opts.addid && push!(idcolumns, target.opts.idcolumn)
  # preserve order of the columns and remove automatically added idcolumns
  newnames = setdiff(intersect(union(oldnames, newnames), newnames), idcolumns)
  DataTable(df[:, newnames], target.opts)
end

end