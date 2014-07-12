ready = ->
  subscription =
    setupForm: ->
      $('#subscription-form').submit ->
        $('#subscription-errors').hide()
        $('input[type=submit]').attr('disabled', true)
        if $('#card_number').length
          subscription.processCard()
          false
        else
          true

    processCard: ->
      card =
        number: $('#card_number').val()
        cvc: $('#card_code').val()
        expMonth: $('#card_month').val()
        expYear: $('#card_year').val()
      Stripe.createToken(card, subscription.handleStripeResponse)

    handleStripeResponse: (status, response) ->
      if status == 200
        $('#token').val(response.id)
        $('#subscription-form')[0].submit()
      else
        console.log(response.error.message)
        $('#subscription-errors').html(response.error.message)
        $('#subscription-errors').show()
        $('input[type=submit]').attr('disabled', false)

  subscription.setupForm()


$(document).ready(ready)
$(document).on('page:load', ready)
