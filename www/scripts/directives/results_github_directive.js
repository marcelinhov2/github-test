(function() {
  var ResultsGithubDirective;

  ResultsGithubDirective = (function() {
    function ResultsGithubDirective() {
      return {
        restrict: 'E',
        templateUrl: '/partials/directives/results_github.html',
        controller: 'resultsGithubController'
      };
    }

    return ResultsGithubDirective;

  })();

  angular.module('app').directive('resultsGithubDirective', [ResultsGithubDirective]);

}).call(this);
