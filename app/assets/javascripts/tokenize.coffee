ready = ->
  $('input.tokenize').tokenfield
    delimiter: ','

$(document).ready(ready)
$(document).on('page:load', ready)
