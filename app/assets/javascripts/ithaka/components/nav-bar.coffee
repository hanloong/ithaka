Ithaka.NavBarComponent = Ember.Component.extend
  tagName: 'header'
  classNames: ['navigation']
  actions:
    toggleSidebar: ->
      $('.sidebar').toggleClass('active')
      $('main').toggleClass('sidebar-open')
    toggleSearch: ->
      $('#site-search').toggleClass('active')
    toggleNotifications: ->
      $('#notifications').toggleClass('active')
