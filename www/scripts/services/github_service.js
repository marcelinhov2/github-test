(function() {
  var Github;

  Github = (function() {
    function Github($q, githubAPIService) {
      return {
        get_users: function(value) {
          var deferred, followers, repos, user;
          deferred = $q.defer();
          repos = githubAPIService.list_user_repos({
            username: value.value
          });
          user = githubAPIService.get({
            service: value.service,
            value: value.value,
            repo: value.repo
          });
          followers = githubAPIService.list_followers({
            username: value.value
          });
          $q.all({
            user: user.$promise.then(function(result) {
              return result;
            }),
            followers: followers.$promise.then(function(result) {
              return result;
            }),
            repos: repos.$promise.then(function(result) {
              return result;
            })
          }).then(function(result) {
            return deferred.resolve(result);
          })["catch"]((function(_this) {
            return function(error) {
              return deferred.reject(error);
            };
          })(this));
          return deferred.promise;
        },
        get_orgs: function(value) {
          var deferred, members, org, repos;
          deferred = $q.defer();
          org = githubAPIService.get({
            service: value.service,
            value: value.value,
            repo: value.repo
          });
          members = githubAPIService.members_list({
            org: value.value
          });
          repos = githubAPIService.list_org_repos({
            org: value.value
          });
          $q.all({
            org: org.$promise.then(function(result) {
              return result;
            }),
            members: members.$promise.then(function(result) {
              return result;
            }),
            repos: repos.$promise.then(function(result) {
              return result;
            })
          }).then(function(result) {
            return deferred.resolve(result);
          })["catch"]((function(_this) {
            return function(error) {
              return deferred.reject(error);
            };
          })(this));
          return deferred.promise;
        },
        get_repos: function(value) {
          var commits, deferred, issues, pull_requests, repo;
          deferred = $q.defer();
          repo = githubAPIService.get({
            service: value.service,
            value: value.value,
            repo: value.repo
          });
          pull_requests = githubAPIService.list_pull_requests({
            owner: value.value,
            repo: value.repo
          });
          issues = githubAPIService.list_issues({
            owner: value.value,
            repo: value.repo
          });
          commits = githubAPIService.list_commits({
            owner: value.value,
            repo: value.repo
          });
          $q.all({
            repo: repo.$promise.then(function(result) {
              return result;
            }),
            pull_requests: pull_requests.$promise.then(function(result) {
              return result;
            }),
            issues: issues.$promise.then(function(result) {
              return result;
            }),
            commits: commits.$promise.then(function(result) {
              return result;
            })
          }).then(function(result) {
            return deferred.resolve(result);
          })["catch"]((function(_this) {
            return function(error) {
              return deferred.reject(error);
            };
          })(this));
          return deferred.promise;
        },
        search: function(type, value) {
          var deferred, search;
          deferred = $q.defer();
          search = githubAPIService.search({
            type: type,
            value: value
          });
          search.$promise.then((function(_this) {
            return function(response) {
              return deferred.resolve(response);
            };
          })(this))["catch"]((function(_this) {
            return function(error) {
              return deferred.reject(error.status);
            };
          })(this));
          return deferred.promise;
        },
        full_search: function(value) {
          var deferred;
          deferred = $q.defer();
          $q.all({
            users: this.search('users', value),
            repos: this.search('repositories', value)
          }).then(function(result) {
            result.orgs = _.filter(result.users.items, {
              type: 'Organization'
            });
            result.users = _.filter(result.users.items, {
              type: 'User'
            });
            result.repos = result.repos.items;
            return deferred.resolve(result);
          })["catch"]((function(_this) {
            return function(error) {
              return deferred.reject(error);
            };
          })(this));
          return deferred.promise;
        }
      };
    }

    return Github;

  })();

  angular.module('app').service('githubService', ['$q', 'githubAPIService', Github]);

}).call(this);
