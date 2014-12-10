Ithaka.NavView = Ember.View.extend
  tagName: 'header'
  classNames: ['navigation']

Ithaka.SidebarToggleView = Ember.View.extend
  tagName: 'span'
  classNames: ['icon-bars']
  click: ->
    $('.sidebar').toggleClass('active')
    $('main').toggleClass('sidebar-open')
