$(document).ready(function(){
  $(".locationUpdate").on( "submit", function() {
    event.preventDefault();
      var location = $('#location').val()
      $('#locationModal').modal('toggle');

      $('.dashboard-container').hide();
      $('.spinner').show();
      $('.update-location').show();
      var user = $.ajax( {
        url: "/api/location/1",
        type: 'PATCH',
        dataType: 'json',
        data: {
                location: location
                }
        })
          .done(function(data) {
          $('#shodometer').empty().append(data);
      });

      $('#dashboardLocation').empty().append(location);

      $(document).ajaxStop(function(){
        $('.spinner').hide();
        $('.update-location').hide();
        $('.dashboard-container').show();
      });
  });
  
})
