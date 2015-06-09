(function() {
  var SearchGithub,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  SearchGithub = (function() {
    function SearchGithub($scope, $rootScope, $timeout, githubService) {
      this.$scope = $scope;
      this.$rootScope = $rootScope;
      this.$timeout = $timeout;
      this.githubService = githubService;
      this.search = bind(this.search, this);
      this.keyup_handler = bind(this.keyup_handler, this);
      this.init = bind(this.init, this);
      this.init();
    }

    SearchGithub.prototype.init = function() {
      this.declare_scope_vars();
      return this.define_template_methods();
    };

    SearchGithub.prototype.declare_scope_vars = function() {
      this.search_timeout = null;
      return this.$scope.form = {};
    };

    SearchGithub.prototype.define_template_methods = function() {
      return this.$scope.keyup_handler = this.keyup_handler;
    };

    SearchGithub.prototype.keyup_handler = function() {
      if (this.search_timeout) {
        this.$timeout.cancel(this.search_timeout);
      }
      return this.search_timeout = this.$timeout((function(_this) {
        return function() {
          return _this.search(_this.$scope.form.search_value);
        };
      })(this), 500);
    };

    SearchGithub.prototype.search = function(value) {
      var full_search;
      full_search = this.githubService.full_search(value);
      return full_search.then((function(_this) {
        return function(result) {
          return _this.$rootScope.$broadcast("GithubSearchDone", result);
        };
      })(this))["catch"]((function(_this) {
        return function(error) {
          return _this.$rootScope.$broadcast("GithubSearchDone", error);
        };
      })(this));
    };

    return SearchGithub;

  })();

  angular.module('app').controller('searchGithubController', ['$scope', '$rootScope', '$timeout', 'githubService', SearchGithub]);

}).call(this);
