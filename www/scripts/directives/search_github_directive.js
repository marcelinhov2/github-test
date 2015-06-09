(function() {
  var SearchGithubDirective;

  SearchGithubDirective = (function() {
    function SearchGithubDirective() {
      return {
        restrict: 'E',
        templateUrl: '/partials/directives/search_github.html',
        controller: 'searchGithubController'
      };
    }

    return SearchGithubDirective;

  })();

  angular.module('app').directive('searchGithubDirective', [SearchGithubDirective]);

}).call(this);
