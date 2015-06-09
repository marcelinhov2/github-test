class Infos extends Controller
  constructor: (
    @$scope
    @$filter
    @$routeParams
    @githubService
  ) -> do @init

  init: ->
    do @declare_scope_vars
    do @declare_template_methods

    do @get

  declare_scope_vars: ->
    @$scope.is_repos_filtered = false

  declare_template_methods: ->
    @$scope.get_repo_type_length = @get_repo_type_length
    @$scope.filter_repos_by = @filter_repos_by

  get_repo_type_length: (type, param) =>
    filter = @build_filter(type, param)

    filtered = _.filter(@$scope.result.users.repos, filter)
    return filtered.length

  filter_repos_by: (type, param) =>
    @$scope.is_repos_fork = param
    filter = @build_filter(type, param)

    if !@repos_bkp
      @repos_bkp = @$scope.result.users.repos

    original = @repos_bkp

    if param isnt undefined
      @$scope.result.users.repos = _.filter(original, filter)
      @$scope.is_repos_filtered = true
    else
      @$scope.result.users.repos = @repos_bkp
      @$scope.is_repos_filtered = false

    return @$scope.result.users.repos

  build_filter: (type, param) ->
    filter = {}
    filter[type] = param

    return filter

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