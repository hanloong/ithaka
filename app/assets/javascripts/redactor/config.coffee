ready = ->
  csrf_token = $('meta[name=csrf-token]').attr('content')
  csrf_param = $('meta[name=csrf-param]').attr('content')
  params
  if (!csrf_param? && !csrf_token?)
    params = csrf_param + "=" + encodeURIComponent(csrf_token)
  $('.redactor').redactor
      imageUpload: "/redactor_rails/pictures?" + params
      imageGetJson: "/redactor_rails/pictures"
      dragUpload: true
      fileUpload: "/redactor_rails/documents?" + params
      fileGetJson: "/redactor_rails/documents"
      path: "/assets/redactor-rails"
      css: "style.css"
      autoresize: false

$(document).ready(ready)
$(document).on('page:load', ready)
