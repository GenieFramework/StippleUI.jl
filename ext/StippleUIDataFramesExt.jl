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
  oldnames = names(df)
  newnames = getindex.(d["columns"], "name")
  # the following line guarantees that the order of the columns is preserved
  newnames = intersect(union(oldnames, newnames), newnames)
  DataTable(df[:, newnames], target.opts)
end

end