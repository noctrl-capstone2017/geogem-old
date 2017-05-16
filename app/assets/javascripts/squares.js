// source: http://stackoverflow.com/questions/9945620/making-a-table-row-into-a-link-in-rails
("tr[data-link]").click(function() {
  window.location = this.data("link")
})