# module App

using GenieFramework
using DataFrames
@genietools

StippleUI.Tables.set_default_rows_per_page(20)
StippleUI.Tables.set_max_rows_client_side(11_000)

# function paginate(dt, data)
#   DataTable!(dt[]; data = data)
# end

@app begin
  big_data = sort!(DataFrame(rand(1_000_000, 2), ["x1", "x2"]))::DataFrame # we only sort so that the changes are more visible when filtering and paginating

  @out dt1 = DataTable(big_data; server_side = true)
  @out dt2 = DataTable(big_data)

  @out loading = false

  @event dt1_request begin
    # @paginate(dt1, big_data)
    # paginate(dt1, big_data)
    @show "called"
    dt1 = DataTable!(dt1; data = big_data)
    @show dt1
    @push
  end
end

@page("/", "ui2.jl")

# end