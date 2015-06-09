(function() {
  var Routes;

  Routes = (function() {
    function Routes($routeProvider, $httpProvider, $locationProvider) {
      $routeProvider.when('/', {
        templateUrl: '/partials/views/home.html'
      }).when('/infos/:service/:value/:repo?', {
        controller: 'infosController',
        templateUrl: function($routeParams) {
          return "/partials/views/infos/" + $routeParams.service + ".html";
        }
      }).otherwise({
        redirectTo: '/'
      });
      $locationProvider.html5Mode(true);
      $httpProvider.interceptors.push('HttpRequestInterceptor');
    }

    return Routes;

  })();

  angular.module('app').config(['$routeProvider', '$httpProvider', '$locationProvider', Routes]);

}).call(this);
