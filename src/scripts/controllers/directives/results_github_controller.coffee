class ResultsGithub extends Controller
  constructor: (
    @$scope
    @$rootScope
  ) -> do @init
    
  init: =>
    do @declare_scope_vars
    do @define_template_methods

    do @set_listeners

  declare_scope_vars: ->

  define_template_methods: ->

  set_listeners: ->
    @$rootScope.$on 'GithubSearchDone', (event, result) =>
      console.log result