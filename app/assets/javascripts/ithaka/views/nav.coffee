Ithaka.NavView = Ember.View.extend
  tagName: 'header'
  classNames: ['navigation']

Ithaka.SidebarToggleView = Ember.View.extend
  tagName: 'p'
  classNames: ['navigation-menu-button']
  click: ->
    $('.sidebar').toggleClass('active')
    $('main').toggleClass('sidebar-open')

Ithaka.NotificationToggleView = Ember.View.extend
  tagName: 'a'
  click: ->
    $('#notifications').toggleClass('active')

Ithaka.SearchToggleView = Ember.View.extend
  tagName: 'a'
  click: ->
    $('#site-search').toggleClass('active')
