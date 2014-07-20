ready = ->
  $(".switch").bootstrapSwitch
    onText: 'Yes'
    offText: 'No'

$(document).ready(ready)
$(document).on('page:load', ready)
