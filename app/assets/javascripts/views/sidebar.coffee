Ithaka.SidebarView = Ember.View.extend
  classNames: ['sidebar']
  mouseEnter: ->
    unless  $(".sidebar").hasClass("active")
      $('main').addClass('sidebar-open')
  mouseLeave: ->
    unless  $(".sidebar").hasClass("active")
      $('main').removeClass('sidebar-open')
