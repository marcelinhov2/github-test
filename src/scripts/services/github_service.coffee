class Github extends Service
  constructor: (
    $q
    githubAPIService
  ) ->
    return {
      users_search: (value) ->
        deferred = do $q.defer

        search_users = githubAPIService.search_users({
          value: value  
        })
        
        search_users.$promise
          .then (response) =>
            deferred.resolve(response)
          .catch (error) =>
            deferred.reject(error.status)

        return deferred.promise

      repos_search: (value) ->
        deferred = do $q.defer

        search_repos = githubAPIService.search_repos({
          value: value  
        })

        search_repos.$promise
          .then (response) =>
            deferred.resolve(response)
          .catch (error) =>
            deferred.reject(error)

        return deferred.promise

      full_search: (value) ->
        full_response = {}

        deferred = do $q.defer

        @users_search(value)
          .then (result) =>
            full_response.orgs = _.filter result.items, {type: 'Organization'}
            full_response.users = _.filter result.items, {type: 'User'}
          .catch (error) =>
            full_response.error = error 
            deferred.reject(full_response)

          @repos_search(value)
            .then (result) =>
              full_response.repos = result.items
              deferred.resolve(full_response)
            .catch (error) =>
              full_response.error = error
              deferred.reject(full_response)

        return deferred.promise
    }