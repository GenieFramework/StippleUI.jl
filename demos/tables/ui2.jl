table(:dt1,
      server_side = true,
      loading = :loading,
      title = "Server side data"
)
table(:dt2,
      loading = :loading,
      title = "Client side data"
)

# ParsedHTMLString("""
# <q-table
#       row-key="__id"
#       :loading="loading"
#       :columns="dt2.columns"
#       title="Random data"
#       :data="dt2.data"
#       :filter="dt2.filter"
#       :pagination.sync="dt2.pagination"
#       v-model="dt2">
#     <template v-slot:top-right>
#       <q-input dense debounce="300" v-model="dt2.filter" placeholder="Search">
#         <template v-slot:append>
#           <q-icon name="search" />
#         </template>
#       </q-input>
#       </template>
# </q-table>
# """)
