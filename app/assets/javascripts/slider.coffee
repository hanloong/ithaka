ready = ->
  $('.influence-slider').each ->
    $(this).slider()
    $(this).parent().css('width', ''); 

$(document).ready(ready)
$(document).on('page:load', ready)
