# For more information see: http://emberjs.com/guides/routing/

Ithaka.Router.map ->
  @resource 'projects', ->
    @route 'new'

    @resource 'ideas', ->
      @route 'new'

# Router settings
Ithaka.Router.reopen
  rootURL: '/app/'
  location: 'history'
