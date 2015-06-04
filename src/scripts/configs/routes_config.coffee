class Routes extends Config
  constructor: ($routeProvider, $locationProvider) ->
      $routeProvider
      .when '/',
        controller: 'homeController'
        templateUrl: '/partials/views/home.html'

      .when '/infos/:service/:value/:repo?',
        controller: 'infosController'
        templateUrl: '/partials/views/infos.html'
      
      .otherwise
        redirectTo: '/'

      $locationProvider.html5Mode true