Ithaka.SidebarView = Ember.View.extend
  classNames: ['sidebar']
  mouseEnter: ->
    $('.sidebar').animate {width: '200px'}, ->
      $('.sidebar .hidden-sidebar').fadeIn 'slow'
  mouseLeave: ->
    $('.sidebar .hidden-sidebar').fadeOut 'slow', ->
      $('.sidebar').animate({width: '45px'})

