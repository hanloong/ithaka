ready = ->
  $('a').click ->
      $('html, body').animate(
          scrollTop: $( $.attr(this, 'href') ).offset().top
      , 500)
      false

$(document).ready(ready)
$(document).on('page:load', ready)
