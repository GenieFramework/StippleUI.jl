table(:dt1,
      paginationsync = Symbol("dt1.pagination"),
      @on("request", :paginate_dt1),
      loading = :loading,
      filter = Symbol("dt1.filter"),
      title = "Random big data"
)
table(:dt2,
      paginationsync = Symbol("dt2.pagination"),
      loading = :loading,
      filter = Symbol("dt2.filter"),
      title = "Random small data"
)