module App

using GenieFramework
using DataFrames
@genietools

@app begin
  NO_OF_ROWS = 1000
  DATA = sort!(DataFrame(rand(NO_OF_ROWS, 2), ["x1", "x2"]))
  ROWS_PER_PAGE = 10

  @out df = DATA
  @out dt = DataTable(DATA) # DataTable(DataFrame([]), DataTableOptions(DATA))
  @out pagination = DataTablePagination(rows_per_page = ROWS_PER_PAGE, rows_number = NO_OF_ROWS)
  @out loading = false
  # @in filter = ""
  @in dfilter = ""

  # @onchange isready begin
  #   dt = DataTable(DATA[1:ROWS_PER_PAGE, :])
  #   filter = ""
  # end

  # @event request begin
  #   loading = true
  #   state = process_request(DATA, dt, pagination, filter)
  #   dt = state.datatable
  #   pagination = state.pagination
  #   loading = false
  # end

  # @onchange filter begin
  #   pagination.page = 1
  #   state = process_request(DATA, dt, pagination, filter)
  #   dt = state.datatable
  #   pagination = state.pagination
  # end
end

@page("/", "ui.jl")

end