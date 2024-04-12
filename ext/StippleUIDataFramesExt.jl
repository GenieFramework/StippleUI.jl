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
  df = Stipple.stipple_parse(DataFrames.DataFrame, d["data"])
  DataTable(df[:, getfield.(target.opts.columns, :name)], target.opts)
end

end