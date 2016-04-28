$( document).ready(function() {
  $(function(){
    $('.shows-body').css({ height: $(window).innerHeight() - 270 });

    $(window).resize(function(){

    $('.shows-body').css({ height:    $(window).innerHeight() - 270 });
    });
  });
});
