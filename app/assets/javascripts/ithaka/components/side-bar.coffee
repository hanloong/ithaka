Ithaka.SideBarComponent = Ember.Component.extend
  mouseEnter: ->
    unless  $(".sidebar").hasClass("active")
      $('main').addClass('sidebar-open')
  mouseLeave: ->
    unless  $(".sidebar").hasClass("active")
      $('main').removeClass('sidebar-open')
  actions:
    toggleDropdown: (target) ->
      $("##{target}").toggleClass('active')
