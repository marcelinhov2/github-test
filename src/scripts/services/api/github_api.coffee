class GithubAPI extends Service
  constructor: (
    @$resource
  ) ->
    base_url = "https://api.github.com/"

    github = @$resource(base_url, {},
      search:
        method: 'GET'
        url: base_url + "search/:type?q=:value"

      get:
        method: 'GET'
        url: base_url + ":service/:value/:repo"
    )

    return {
      search: github.search
      get: github.get
    }