const tableMixin = {
  methods: {
    addTableInfo: function (event, row, id) {
        const keys = Object.keys(row)
        event.row = row.__id;
        event.column = event.target.closest('td').cellIndex + 1;
        // we have defined column index to start from 1 for indexing the underlying Julia DataFrame
        // but it is also correct for indexing here, as the first column is the index column
        // note, we need to do the indexing here, as we are parsing into Dicts that do not keep the order of the keys
        event.value = row[keys[event.column]];
        event.row_data = row;
        event.column_keys = keys;
        return event;
    }
  }
}
