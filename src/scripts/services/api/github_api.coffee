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

      members_list:
        method: 'GET'
        url: base_url + "orgs/:org/members"
        isArray: true

      list_org_repos:
        method: 'GET'
        url: base_url + "orgs/:org/repos"
        isArray: true

      list_pull_requests:
        method: 'GET'
        url: base_url + "repos/:owner/:repo/pulls"
        isArray: true

      list_issues:
        method: 'GET'
        url: base_url + "repos/:owner/:repo/issues"
        isArray: true

      list_commits:
        method: 'GET'
        url: base_url + "repos/:owner/:repo/commits"
        isArray: true

      list_followers:
        method: 'GET'
        url: base_url + "users/:username/followers"
        isArray: true

      list_user_repos:
        method: 'GET'
        url: base_url + "users/:username/repos"
        isArray: true
    )

    return {
      search: github.search
      get: github.get
      members_list: github.members_list
      list_org_repos: github.list_org_repos
      list_pull_requests: github.list_pull_requests
      list_issues: github.list_issues
      list_commits: github.list_commits
      list_followers: github.list_followers
      list_user_repos: github.list_user_repos
    }