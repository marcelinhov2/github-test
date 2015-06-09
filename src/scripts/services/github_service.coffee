class Github extends Service
  constructor: (
    $q
    githubAPIService
  ) ->
    return {
      get_users: (value) ->
        deferred = do $q.defer

        repos = githubAPIService.list_user_repos(
          username: value.value
        )

        user = githubAPIService.get(
          service: value.service
          value: value.value
          repo: value.repo
        )

        followers = githubAPIService.list_followers(
          username: value.value
        )

        $q.all(
          user: user.$promise.then (result) ->
            return result
          followers: followers.$promise.then (result) ->
            return result
          repos: repos.$promise.then (result) ->
            return result
        )

        .then (result) ->
          deferred.resolve(result)
        .catch (error) =>
          deferred.reject(error)

        return deferred.promise

      get_orgs: (value) ->
        deferred = do $q.defer

        org = githubAPIService.get(
          service: value.service
          value: value.value
          repo: value.repo
        )

        members = githubAPIService.members_list(
          org: value.value
        )

        repos = githubAPIService.list_org_repos(
          org: value.value
        )

        $q.all(
          org: org.$promise.then (result) ->
            return result
          members: members.$promise.then (result) ->
            return result
          repos: repos.$promise.then (result) ->
            return result
        )

        .then (result) ->
          deferred.resolve(result)
        .catch (error) =>
          deferred.reject(error)

        return deferred.promise

      get_repos: (value) ->
        deferred = do $q.defer

        repo = githubAPIService.get(
          service: value.service
          value: value.value
          repo: value.repo
        )

        pull_requests = githubAPIService.list_pull_requests(
          owner: value.value
          repo: value.repo
        )

        issues = githubAPIService.list_issues(
          owner: value.value
          repo: value.repo
        )

        commits = githubAPIService.list_commits(
          owner: value.value
          repo: value.repo
        )

        $q.all(
          repo: repo.$promise.then (result) ->
            return result
          pull_requests: pull_requests.$promise.then (result) ->
            return result
          issues: issues.$promise.then (result) ->
            return result
          commits: commits.$promise.then (result) ->
            return result
        )

        .then (result) ->
          deferred.resolve(result)
        .catch (error) =>
          deferred.reject(error)

        return deferred.promise

      search: (type, value) ->
        deferred = do $q.defer

        search = githubAPIService.search({
          type: type  
          value: value  
        })
        
        search.$promise
          .then (response) =>
            deferred.resolve(response)
          .catch (error) =>
            deferred.reject(error.status)

        return deferred.promise

      full_search: (value) ->
        deferred = do $q.defer

        $q.all({
          users: @search('users', value)
          repos: @search('repositories', value)
        })
        .then (result) ->
          result.orgs = _.filter result.users.items, {type: 'Organization'}
          result.users = _.filter result.users.items, {type: 'User'}
          result.repos = result.repos.items

          deferred.resolve(result)
        .catch (error) =>
          deferred.reject(error)

        return deferred.promise
    }