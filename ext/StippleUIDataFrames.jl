function StippleUI.QTables.DataTable()
  DataTable(DataFrames.DataFrame())
end

function StippleUI.DataTableWithSelection()
  DataTableWithSelection(DataTable(),  DataTablePagination(), DataTableSelection())
end

function Stipple.convertvalue(target::Stipple.R{<:DataTable{DataFrames.DataFrame}}, d::AbstractDict)
  df = Stipple.stipple_parse(DataFrames.DataFrame, d["data"])
  DataTable(df[:, names(df) .!== "__id"], target.opts)
end