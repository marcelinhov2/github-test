class GithubAPI extends Service
  constructor: (
    @$resource
  ) ->
    base_url = "https://api.github.com/"

    github = @$resource(base_url + "search", {},
      search_users:
        method: 'GET'
        url: base_url + "search/users?q=:value"

      search_repos:
        method: 'GET'
        url: base_url + "search/repositories?q=:value"
    )

    return {
      search_users: github.search_users
      search_repos: github.search_repos
    }