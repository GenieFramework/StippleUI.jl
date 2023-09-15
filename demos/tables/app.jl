using GenieFramework
using DataFrames
@genietools


@app begin
  NO_OF_ROWS = 10_000
  DATA = sort!(DataFrame(rand(NO_OF_ROWS, 2), ["x1", "x2"]))
  ROWS_PER_PAGE = 10

  @out data = DataTable(DataFrame([]), DataTableOptions(DATA))
  @out pagination = DataTablePagination(rows_per_page = ROWS_PER_PAGE, rows_number = NO_OF_ROWS)
  @out loading = false
  @in filter = ""

  @onchange isready begin
    data = DataTable(DATA[1:ROWS_PER_PAGE, :])
    filter = ""
  end

  @event :request begin
    loading = true
    state = process_request(DATA, data, pagination, filter)
    @show state
    data = state.datatable
    pagination = state.pagination
    loading = false
  end

  @onchange filter begin
    pagination.page = 1
    state = process_request(DATA, data, pagination, filter)
    data = state.datatable
    pagination = state.pagination
  end
end

@page("/", "ui.jl")