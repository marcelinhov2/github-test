(function() {
  var App;

  App = (function() {
    function App($scope) {
      this.$scope = $scope;
      this.init();
    }

    App.prototype.init = function() {};

    return App;

  })();

  angular.module('app').controller('appController', ['$scope', App]);

}).call(this);
