class Github extends Service
  constructor: (
    $q
    githubAPIService
  ) ->
    return {
      get_users: (data) ->
        full_response = {}

        deferred = do $q.defer

        get = githubAPIService.get({
          service: data.service
          value: data.value
          repo: data.repo
        })
        
        get.$promise
          .then (response) =>
            console.log '@@@@@@@@@@@@@@@@@@'
            console.log response
            console.log '@@@@@@@@@@@@@@@@@@'

            full_response = response

            list_followers = githubAPIService.list_followers({
              username: response.login
            })

            list_followers.$promise
              .then (response) =>
                console.log response

                full_response.followers = response
                deferred.resolve(response)

              .catch (error) =>
                deferred.reject(error.status)
            
          .catch (error) =>
            deferred.reject(error.status)

        return deferred.promise

      get_orgs: (data) ->
        deferred = do $q.defer

        get = githubAPIService.get({
          service: data.service
          value: data.value
          repo: data.repo
        })
        
        get.$promise
          .then (response) =>
            deferred.resolve(response)
          .catch (error) =>
            deferred.reject(error.status)

        return deferred.promise

      get_repos: (data) ->
        deferred = do $q.defer

        get = githubAPIService.get({
          service: data.service
          value: data.value
          repo: data.repo
        })
        
        get.$promise
          .then (response) =>
            deferred.resolve(response)
          .catch (error) =>
            deferred.reject(error.status)

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