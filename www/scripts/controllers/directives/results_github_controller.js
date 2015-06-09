(function() {
  var ResultsGithub,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  ResultsGithub = (function() {
    function ResultsGithub($scope, $rootScope) {
      this.$scope = $scope;
      this.$rootScope = $rootScope;
      this.init = bind(this.init, this);
      this.init();
    }

    ResultsGithub.prototype.init = function() {
      return this.set_listeners();
    };

    ResultsGithub.prototype.set_listeners = function() {
      return this.$rootScope.$on('GithubSearchDone', (function(_this) {
        return function(event, result) {
          return _this.$scope.results = result;
        };
      })(this));
    };

    return ResultsGithub;

  })();

  angular.module('app').controller('resultsGithubController', ['$scope', '$rootScope', ResultsGithub]);

}).call(this);
