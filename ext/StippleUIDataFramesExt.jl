module StippleUIDataFramesExt

@static if isdefined(Base, :get_extension)
  using DataFrames
  using StippleUI
  using StippleUI.Stipple
end

function StippleUI.QTables.DataTable()
  DataTable(DataFrames.DataFrame())
end

function Stipple.convertvalue(target::Stipple.R{<:DataTable{DataFrames.DataFrame}}, d::AbstractDict)
  df = Stipple.stipple_parse(DataFrames.DataFrame, d["data"])
  DataTable(df[:, names(df) .!== "__id"], target.opts)
end

end