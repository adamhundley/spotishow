$(document).ready(function() {
  $('.carousel').carousel({
    interval: 2500
  });

  $('.login-button').click(function() {
    $('.login-button').hide();
    $('.slides-caption').hide();
    $('.spinner').show();
  });

  function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(sendLocation);
    } else {
        console.log("Geolocation is not supported by this browser.");
    }
  }

  function sendLocation(position) {
    $.post('/api/location', {lat:position.coords.latitude, lng:position.coords.longitude});
  }
    if(window.attachEvent) {
        window.attachEvent('onload', getLocation());
    } else {
        if(window.onload) {
            var curronload = window.onload;
            var newonload = function(evt) {
                curronload(evt);
                getLocation(evt);
            };
            window.onload = newonload;
        } else {
            window.onload = getLocation();
        }
    }

})
