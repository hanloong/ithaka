Ithaka.NavView = Ember.View.extend
  tagName: 'header'
  classNames: ['navigation']

Ithaka.SidebarToggleView = Ember.View.extend
  tagName: 'p'
  classNames: ['navigation-menu-button']
  click: ->
    $('.sidebar').toggleClass('active')
    $('main').toggleClass('sidebar-open')
