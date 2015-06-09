(function() {
  var Infos,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Infos = (function() {
    function Infos($scope, $filter, $routeParams, githubService) {
      this.$scope = $scope;
      this.$filter = $filter;
      this.$routeParams = $routeParams;
      this.githubService = githubService;
      this.filter_repos_by = bind(this.filter_repos_by, this);
      this.get_repo_type_length = bind(this.get_repo_type_length, this);
      this.init();
    }

    Infos.prototype.init = function() {
      this.declare_scope_vars();
      this.declare_template_methods();
      return this.get();
    };

    Infos.prototype.declare_scope_vars = function() {
      return this.$scope.is_repos_filtered = false;
    };

    Infos.prototype.declare_template_methods = function() {
      this.$scope.get_repo_type_length = this.get_repo_type_length;
      return this.$scope.filter_repos_by = this.filter_repos_by;
    };

    Infos.prototype.get_repo_type_length = function(type, param) {
      var filter, filtered;
      filter = this.build_filter(type, param);
      filtered = _.filter(this.$scope.result.users.repos, filter);
      return filtered.length;
    };

    Infos.prototype.filter_repos_by = function(type, param) {
      var filter, original;
      this.$scope.is_repos_fork = param;
      filter = this.build_filter(type, param);
      if (!this.repos_bkp) {
        this.repos_bkp = this.$scope.result.users.repos;
      }
      original = this.repos_bkp;
      if (param !== void 0) {
        this.$scope.result.users.repos = _.filter(original, filter);
        this.$scope.is_repos_filtered = true;
      } else {
        this.$scope.result.users.repos = this.repos_bkp;
        this.$scope.is_repos_filtered = false;
      }
      return this.$scope.result.users.repos;
    };

    Infos.prototype.build_filter = function(type, param) {
      var filter;
      filter = {};
      filter[type] = param;
      return filter;
    };

    Infos.prototype.get = function() {
      var get;
      get = this.githubService['get_' + this.$routeParams.service]({
        service: this.$routeParams.service,
        value: this.$routeParams.value,
        repo: this.$routeParams.repo
      });
      return get.then((function(_this) {
        return function(result) {
          _this.$scope.result = {};
          return _this.$scope.result[_this.$routeParams.service] = result;
        };
      })(this));
    };

    return Infos;

  })();

  angular.module('app').controller('infosController', ['$scope', '$filter', '$routeParams', 'githubService', Infos]);

}).call(this);
