table(:dt,
      paginationsync = Symbol("dt.pagination"),
      @on("request", :request),
      loading = :loading,
      filter = Symbol("dt.filter"),
      title = "Random data"
)