# table(:dt, paginationsync = :pagination, @on("request", :request), loading = :loading, filter = :filter, title = "Random data")
Stipple.table(:dt, class="table-white-row", pagination=:pagination, dense=true, hide__pagination=false, filter=:dfilter,
  template(var"v-slot:top-right"="",
    textfield("", hint="Search by any keywords", :dfilter, borderless="", dense="", debounce="300", placeholder="Search", [
      template(var"v-slot:append"=true,
        icon("search")
      )]
    )
  )
)