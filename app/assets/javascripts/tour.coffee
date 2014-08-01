@tour = ->
  $("#modal-tour").modal()

  ithaka_content = 'This project allows you to submit idea for improving Ithaka'
  ithaka_button = '<button type="button" class="btn btn-default" id="step1">Next</button>'
  ithaka_po = $("#ithaka").popover
    trigger: 'manual'
    title: 'Ithaka project'
    container: 'body'
    html: true
    content: "<p>#{ithaka_content}</p>#{ithaka_button}"

  sandbox_content = 'This project is a playground for you to try out all the features Ithaka has to offer'
  sandbox_button = '<button type="button" class="btn btn-default" id="step2">Next</button>'
  $("#sandbox").popover
    trigger: 'manual'
    title: 'Sandbox project'
    container: 'body'
    html: true
    placement: 'top'
    content: "<p>#{sandbox_content}</p>#{sandbox_button}"

  new_content = "Once you've tried out the sandbox it's time to create your first project"
  new_button = '<button type="button" class="btn btn-default" id="step3">Next</button>'
  $("#new-project").popover
    trigger: 'manual'
    title: 'Create a project'
    container: 'body'
    html: true
    placement: 'top'
    content: "<p>#{new_content}</p>#{new_button}"

  invite_content = "When you have your projects setup its time to invite your team and let the <strong>Ideation</strong> begin."
  invite_button = '<button type="button" class="btn btn-default" id="step4">Next</button>'
  $("#invite").popover
    trigger: 'manual'
    title: 'Better with friends'
    container: 'body'
    html: true
    placement: 'bottom'
    content: "<p>#{invite_content}</p>#{invite_button}"

  $('#start-tour').on 'click', ->
    $('#modal-tour').modal('toggle')
    $('#ithaka').popover('show')

    $('#step1').on 'click', ->
      $('#ithaka').popover('hide')
      $('#sandbox').popover('show')

      $('#step2').on 'click', ->
        $('#sandbox').popover('hide')
        $('#new-project').popover('show')

        $('#step3').on 'click', ->
          $('#new-project').popover('hide')
          $('#invite').popover('show')

          $('#step4').on 'click', ->
            $('#invite').popover('hide')
            $('#modal-tour-finish').modal()
