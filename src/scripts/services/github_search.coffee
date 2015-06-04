class GithubSearch extends Service
  constructor: (
    $q
    githubAPIService
  ) ->
    return {
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
        full_response = {}

        deferred = do $q.defer

        @search('users', value)
          .then (result) =>
            full_response.orgs = _.filter result.items, {type: 'Organization'}
            full_response.users = _.filter result.items, {type: 'User'}
          .catch (error) =>
            full_response.error = error 
            deferred.reject(full_response)

          @search('repositories', value)
            .then (result) =>
              full_response.repos = result.items
              deferred.resolve(full_response)
            .catch (error) =>
              full_response.error = error
              deferred.reject(full_response)

        return deferred.promise
    }