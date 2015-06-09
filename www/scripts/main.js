(function() {
  var App;

  App = (function() {
    function App() {
      return ['templates', 'ngResource', 'ngRoute'];
    }

    return App;

  })();

  angular.module('app', new App());

}).call(this);
