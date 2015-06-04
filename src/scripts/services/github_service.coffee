class Github extends Service
  constructor: (
    $q
    githubAPIService
  ) ->
    return {
      get_users: (value) ->
        deferred = do $q.defer

        $q.all(
          user: githubAPIService.get(
            service: value.service
            value: value.value
            repo: value.repo
          )
          followers: githubAPIService.list_followers(
            username: value.value
          )
          repos: githubAPIService.list_user_repos(
            username: value.value
          )
        )

        .then (result) ->
          deferred.resolve(result)
        .catch (error) =>
          deferred.reject(error)

        return deferred.promise

      get_orgs: (value) ->
        deferred = do $q.defer

        $q.all(
          org: githubAPIService.get(
            service: value.service
            value: value.value
            repo: value.repo
          )
          members: githubAPIService.members_list(
            org: value.value
          )
          repos: githubAPIService.list_org_repos(
            org: value.value
          )
        )

        .then (result) ->
          deferred.resolve(result)
        .catch (error) =>
          deferred.reject(error)

        return deferred.promise

      get_repos: (value) ->
        deferred = do $q.defer

        $q.all(
          repo: githubAPIService.get(
            service: value.service
            value: value.value
            repo: value.repo
          )
          pull_requests: githubAPIService.list_pull_requests(
            owner: value.value
            repo: value.repo
          )
          issues: githubAPIService.list_issues(
            owner: value.value
            repo: value.repo
          )
          commits: githubAPIService.list_commits(
            owner: value.value
            repo: value.repo
          )
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