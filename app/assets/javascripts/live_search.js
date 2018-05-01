$(document).ready(function() {
  $("#live-search").on("keyup", function() {
    var value = $(this).val().toLowerCase();

    $("table tr").each(function(index) {
      if (index !== 0) {
        $row = $(this);
        var code = $row.find("td:first").text().toLowerCase();
        var name = $row.find("td:nth-child(2)").text().toLowerCase();
        if (name.indexOf(value) !== 0 && code.indexOf(value) !== 0) {
          $row.hide();
        } else {
          $row.show();
        }
      }
    });
  });
})
