class Infos extends Controller
  constructor: (
    @$scope
    @$routeParams
    @githubService
  ) -> do @init

  init: ->
    do @get

  get: ->
    get = @githubService['get_' + @$routeParams.service](
      service: @$routeParams.service
      value: @$routeParams.value
      repo: @$routeParams.repo
    )

    get
      .then (result) =>
        @$scope.result = {}
        @$scope.result[@$routeParams.service] = result
        console.log '--------------------'
        console.log @$scope.result
        console.log '--------------------'
      .catch (error) =>
        console.log '********************'
        console.log error
        console.log '********************'
