class SearchGithubDirective extends Directive
  constructor: ->
    return {
      restrict: 'E'
      templateUrl: '/partials/directives/search_github.html'
      controller: 'searchGithubController'
    }