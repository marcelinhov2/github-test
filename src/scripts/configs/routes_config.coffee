class Routes extends Config
  constructor: (
    $routeProvider
    $httpProvider
    $locationProvider
  ) ->
      $routeProvider
      .when '/',
        controller: 'homeController'
        templateUrl: '/partials/views/home.html'

      .when '/infos/:service/:value/:repo?',
        controller: 'infosController'
        templateUrl: ($routeParams) ->
          return "/partials/views/infos/#{$routeParams.service}.html"
      
      .otherwise
        redirectTo: '/'

      $locationProvider.html5Mode true
      $httpProvider.interceptors.push('HttpRequestInterceptor');