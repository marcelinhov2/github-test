class SearchGithub extends Controller
  constructor: (
    @$scope
    @$rootScope
    @$timeout
    @githubService
  ) -> do @init
    
  init: =>
    do @declare_scope_vars
    do @define_template_methods

  declare_scope_vars: ->
    @search_timeout = null
    @$scope.form = {}

  define_template_methods: ->
    @$scope.keyup_handler = @keyup_handler

  keyup_handler: =>
    if @search_timeout then @$timeout.cancel(@search_timeout)

    @search_timeout = @$timeout( =>
      @search @$scope.form.search_value
    , 500)
      
  search: (value) =>
    full_search = @githubService.full_search(value)
    full_search.then (result) =>
      @$rootScope.$broadcast "GithubSearchDone", result