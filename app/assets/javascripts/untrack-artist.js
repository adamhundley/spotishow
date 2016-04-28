$(document).ready(function(){

  $(document).on('click', '.untrack-artist', function() {
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

})
