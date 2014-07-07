jQuery ->
  subscription.setupForm()

  subscription =
    setupForm: ->
      $('#subscription-form').submit ->
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
      Stripe.createToken(card, payment.handleStripeResponse)

    handleStripeResponse: (status, response) ->
      if status == 200
        $('#stripe_card_token').val(response.id)
        $('#payment-form')[0].submit()
      else
        console.log(response.error.message)
        $('#payment-errors').html(response.error.message)
        $('input[type=submit]').attr('disabled', false)
