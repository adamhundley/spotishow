$( document).ready(function() {

  $(".addArtist").on( "submit", function() {
    event.preventDefault();
      $('.search-bar').hide();
      $('.spinner').show();
      var id = $(this).attr('data-id')

      var artist = $.post( "/api/artists", { name:   $('#name').val()}, function(data) {
        if(artist.responseJSON !== null) {
          addArtistToTable(artist.responseJSON);
        } else {
          
        }
      });

      var addArtistToTable = function(artist) {
          html = "<tr class=\"artists\" id=\"artist-"+ artist.id + "\">";
          html += "<td class=\"artists artist-images\"><img src=" + artist.spotify_image_url + " class=\"artist-image\"></td>";
          html += "<td class=\"artists artist-name\"><h1 class=\"artist-name-text\">" + artist.name + "</h1></td>";
          html += "<td class=\"artists artist-facebook\"><a data-target=\"#artist-"+ artist.id+"-modal\" data-toggle=\"modal\" class=\"artist-tour\" id=\"artist-tour-"+artist.id+"\" data-artist=\'"+ artist.name + "\' data-id=\'"+ artist.id+"\'href=\"#\"><img src=\"/assets/calendar-b5411d424ce835674e2e3c352138c15a9409263f99bdf999125900fc7f971875.png\" class=\"live\"></a></td>";
          html += "<td class=\"artists spotify\"><a href='" + artist.spotify_uri + "'><img src=\"/assets/spotify-1bd658c8a2f4520e3db142d411fb8b698b4aff381ebf59b0fa62e8ef4c57c3da.png\" class=\"listen-on-spotify\"></a></td>";
          html += "<td class=\"artists artists-untrack\"><a href=\"#\" class=\"untrack-artist\" id=\"untrack\" data-id='" + artist.id + "' data-uid='"+ id +"'><img src=\"/assets/close_red-b8c43825bd0f2c324e61ea0c7ecbe2de453a9f17deada087b0436a519d0bfbd8.png\" class=\"untrack\"></a></td>";
          html += "</tr>";

          $(".artists-body").prepend(html);
        };

      $(document).ajaxStop(function(){
        $('.search-bar').show();
        $(".spinner").hide();
        $("#name").val();
      });

  });

});
