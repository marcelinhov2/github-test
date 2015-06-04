class Infos extends Controller
  constructor: (
    @$scope
    @$routeParams
    @githubAPIService
  ) -> do @init

  init: ->
    do @get

  get: ->
    get = @githubAPIService.get(
      service: @$routeParams.service
      value: @$routeParams.value
      repo: @$routeParams.repo
    )

    get.$promise
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
