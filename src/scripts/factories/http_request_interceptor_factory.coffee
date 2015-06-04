class HttpRequestInterceptor extends Factory
  constructor: ->
    client_id = '6d994841237006e30c62'
    client_secret = '6766cdfb1223093895862376fb7d5fc45e7b7285'

    return {
      request: (config) =>
        if config.url.indexOf('api.github') > 0
          if config.url.indexOf('?') > 0
            config.url = config.url + "&client_id=#{client_id}&client_secret=#{client_secret}"
          else
            config.url = config.url + "?client_id=#{client_id}&client_secret=#{client_secret}"
        
        return config
    }