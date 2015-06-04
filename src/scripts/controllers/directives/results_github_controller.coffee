class ResultsGithub extends Controller
  constructor: (
    @$scope
    @$rootScope
  ) -> do @init
    
  init: =>
    do @set_listeners

  set_listeners: ->
    @$rootScope.$on 'GithubSearchDone', (event, result) =>
      @$scope.results = result