Ithaka.ApplicationRoute = Ember.Route.extend
  model: ->
    Ember.RSVP.hash
      projects: @store.find 'project'
      current_user: $.getJSON '/api/v1/current_user', (data) =>
        user = data.user
        @store.push('user', user)
        return @store.find('user', user.id)
