// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require bootstrap-sprockets

$( document).ready(function() {

  $('.locationIcon').click(function(){
    navigator.geolocation.getCurrentPosition(sendLocation);

    function sendLocation(position) {
      $.post('/api/location', {lat:position.coords.latitude, lng:position.coords.longitude});
    }
  });

  $('.untrack-artist').click(function() {
    var id = $(this).attr('data-id')
    var uid = $(this).attr('data-uid')
    $.ajax({
      url: "/api/artists/"+id+"",
      type: 'DELETE',
      dataType: "json",
      data: {
              'id': id,
            }
    });

    $('.artist-table .artists-body #artist-'+id+'').hide();
  });

  $(".addArtist").on( "submit", function() {
    event.preventDefault();
      $('.addArtist').hide();
      $('.spinner').show();
      var uid = $(this).attr('data-uid')

      var $form = $( this ),
            url = $form.attr( 'name' );

      var artist = $.post( "/api/artists", { name:   $('#name').val()}, function(data) {
        addArtistToTable(artist.responseJSON);
      });

      var addArtistToTable = function(artist) {
          html = "<tr class=\"artists\">";
          html += "<td class=\"artists artist-images\"><img src=" + artist.spotify_image_url + " class=\"artist-image\"></td>";
          html += "<td class=\"artists artist-name\">" + artist.name + "</td>";
          html += "<td class=\"artists artist-facebook\"><a href='" + artist.facebook_url + "'><img src=\"/assets/live-501097c9b432f8e2a82417837f373bc8e6adacf8700478cdb9443677379b21a2.png\" class=\"live\"></a></td>";
          html += "<td class=\"artists spotify\"><a href='" + artist.spotify_uri + "'><img src=\"/assets/listen-on-spotify-7fb08c990de8117a2be97791057e44073b2f363459edfbdceb6f634c23a2d24d.png\" class=\"listen-on-spotify\"></a></td>";
          html += "<td class=\"artists artists-untrack\"><button type=\"button\" name=\"button\" class=\"btn btn-danger btn-md untrack-artist\" data-id='" + artist.id + ", data-uid='" + uid + ">untrack</button></td>";
          html += "</tr>";
          $(".artists-body").prepend(html);
        };

      $(document).ajaxStop(function(){
        $(".spinner").hide();
      });

  });


  $('#login-button').click(function() {
    $('#login-button').hide();
    $('.welcome-text').hide();
  });

  $('#login-button').click(function() {
    $('.spinner').show();
  });

});
