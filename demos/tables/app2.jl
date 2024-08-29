module App

using GenieFramework
using DataFrames
@genietools

@app begin
  DATA = sort!(DataFrame(rand(1_000_000, 2), ["x1", "x2"]))::DataFrame # we only sort so that the changes are more visible when filtering and paginating

  @out dt = DataTable(DataFrame(x1=[], x2=[]))

  @onchange isready begin
    dt.data = DataFrame(DATA[1:StippleUI.Tables.DEFAULT_ROWS_PER_PAGE, :])
    @push
  end

  @event request begin
    dt = DataTable!(dt[]; data = DATA)
    @push
  end
end

@page("/", "ui2.jl.html")

end