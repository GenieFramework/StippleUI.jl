module App

using GenieFramework
using DataFrames
@genietools

StippleUI.Tables.set_max_rows_client_side(2000)

@app begin
  big_data = sort!(DataFrame(rand(1_000_000, 2), ["x1", "x2"]))::DataFrame # we only sort so that the changes are more visible when filtering and paginating
  small_data = sort!(DataFrame(rand(1_001, 2), ["y1", "y2"]))::DataFrame

  @out dt1 = DataTable(big_data; rows_per_page = 20)
  @out dt2 = DataTable(small_data; rows_per_page = 20, server_side = false)

  @out loading = false

  @event paginate_dt1 begin
    @paginate(dt1, big_data)
    @push
  end

end

# @page("/", "ui2.jl.html")
@page("/", "ui2.jl")

end