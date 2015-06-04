class Routes extends Config
  constructor: ($routeProvider, $locationProvider) ->
      $routeProvider
      .when '/',
        controller: 'homeController'
        templateUrl: '/partials/views/home.html'
      .otherwise
        redirectTo: '/'

      $locationProvider.html5Mode true