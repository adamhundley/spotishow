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



  $('#login-button').click(function() {
    $('#login-button').hide();
    $('.welcome-text').hide();
  });

  $('#login-button').click(function() {
    $('.spinner').show();
  });

});
