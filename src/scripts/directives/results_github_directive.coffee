class ResultsGithubDirective extends Directive
  constructor: ->
    return {
      restrict: 'E'
      templateUrl: '/partials/directives/results_github.html'
      controller: 'resultsGithubController'
    }