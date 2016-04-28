$( document).ready(function() {

  $(document).on('click', '.artist-tour', function(){
    var artist = $(this).attr('data-artist')
    var id = $(this).attr('data-id')
    $('.modal-spinner').show().delay(2000);

    $.getJSON("/api/artists/"+artist+"", function(data){
      if (data.length === 0 ) {
        $("#show-modal-body-"+id+"").append("<h2>...No upcoming shows...</h2>")
      } else {
      $.each(data, function(key, show) {
        renderShowRow(show);
      });
    }
  })

  var renderShowRow = function(show) {
    date = new Date(show.datetime);
    month = parseInt(date.getMonth()) + 1
    html = "<tr class=\"show-row\">";
    html += "<td class=\"\">" + month + "/" + date.getDate() + "</td>";
    html += "<td class=\"\">" + show.venue_name + "</td>";
    html += "<td class=\"\">" + show.formatted_location + "</td>";
    html += "<td class=\"\"><a href='" + show.ticket_url + "'target=\"_blank\">Tickets</a></td>";
    html += "<td class=\"\"><a href='" + show.facebook_rsvp_url + "'target=\"_blank\">RSVP</a></td>";
    html += "</tr>";
    $("#show-modal-body-"+id+"").append(html)
  }
    $(document).ajaxStop(function(){
      $(".modal-spinner").hide();
    });
  });
});
