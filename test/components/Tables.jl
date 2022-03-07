module Tables

using Stipple
using StippleUI
using DataFrames

dt = DataFrame(rand(100000,2), ["x1", "x2"])
dt_opts = DataTableOptions(columns = [Column("x1"), Column("x2", align = :right)])

@reactive mutable struct TableModel <: ReactiveModel
  data::R{DataTable} = DataTable()
  data_pagination::DataTablePagination = DataTablePagination(rows_per_page=50)
end

function handlers(model)

  on(model.isready) do isready
    isready || return 

    model.data[] = DataTable(dt, dt_opts)
  end

  model
end

function ui(table_model)
  page(
    table_model,
    title = "Checkbox Components",
    class = "container",
    [
      table(title="Random numbers", :data; pagination=:data_pagination, style="height: 350px;") 
    ],
  )
end

function factory()
  table_model = TableModel |> init |> handlers
  table_model
end

end