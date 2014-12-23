Ithaka.ApplicationRoute = Ember.Route.extend
  model: ->
    Ember.RSVP.hash
      projects: @store.find 'project'
      current_user: $.getJSON '/api/v1/current_user', (data) =>
        @store.push('user', data.user)
        return @store.find('user', data.user.id)
