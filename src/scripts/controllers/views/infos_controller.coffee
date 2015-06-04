class Infos extends Controller
  constructor: (
    @$scope
    @$routeParams
    @githubService
  ) -> do @init

  init: ->
    console.log @$routeParams
    do @get

  get: ->
    get = @githubService.get(
      service: @$routeParams.service
      value: @$routeParams.value
      repo: @$routeParams.repo
    )

    get
      .then (result) =>
        console.log '--------------------'
        console.log result
        console.log '--------------------'
      .catch (error) =>
        console.log '********************'
        console.log error
        console.log '********************'
