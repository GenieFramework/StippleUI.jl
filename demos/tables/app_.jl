module App

using GenieFramework
using DataFrames
@genietools

@app begin
  NO_OF_ROWS = 1_000_000
  DATA = sort!(DataFrame(rand(NO_OF_ROWS, 2), ["x1", "x2"]))::DataFrame # we only sort so that the changes are more visible when filtering and paginating
  ROWS_PER_PAGE = 100

  @out df = DATA
  @out dt = DataTable(DataFrame([]), DataTableOptions(DATA))
  @out pagination = DataTablePagination(rows_per_page = ROWS_PER_PAGE, rows_number = NO_OF_ROWS)
  @out loading = false
  @in filter = ""

  @onchange isready begin
    dt = DataTable(DATA[1:ROWS_PER_PAGE, :])
    filter = ""
  end

  @event request begin
    loading = true
    state = process_request(DATA, dt, pagination, filter)
    dt = state.datatable
    pagination = state.pagination
    loading = false
  end

  @onchange filter begin
    loading = true
    pagination.page = 1
    state = process_request(DATA, dt, pagination, filter)
    dt = state.datatable
    pagination = state.pagination
    loading = false
  end
end

@page("/", "ui.jl")

end