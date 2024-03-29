module App

using GenieFramework
using DataFrames
@genietools

@app begin
  NO_OF_ROWS = 10_000
  DATA = sort!(DataFrame(rand(NO_OF_ROWS, 2), ["x1", "x2"]))
  ROWS_PER_PAGE = 10

  @out df = DATA
  @out dt = DataTable(DataFrame([]), DataTableOptions(DATA))

  @out pagination = DataTablePagination(rows_per_page = ROWS_PER_PAGE, rows_number = NO_OF_ROWS)
  @out loading = false
  @in filter = ""
end

end