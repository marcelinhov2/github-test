class Infos extends Controller
  constructor: (
    @$scope
    @$routeParams
    @githubService
  ) -> do @init

  init: ->
    do @declare_template_methods

    do @get

  declare_template_methods: ->
    @$scope.filter_by_fork = @filter_by_fork

  filter_by_fork: (is_fork) =>
    total = _.filter(@$scope.result.users.repos, {fork: is_fork}).length
    return total

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

