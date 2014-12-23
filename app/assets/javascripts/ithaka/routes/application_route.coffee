Ithaka.ApplicationRoute = Ember.Route.extend
  model: ->
    return Ember.RSVP.hash
      projects: @store.find('project')
