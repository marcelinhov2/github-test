class SearchDirective extends Directive
  constructor: ->
    return {
      restrict: 'E'
      templateUrl: '/partials/directives/search.html'
      controller: 'searchController'
    }