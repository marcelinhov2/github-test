(function() {
  var HttpRequestInterceptor;

  HttpRequestInterceptor = (function() {
    function HttpRequestInterceptor() {
      var client_id, client_secret, client_string;
      client_id = '6d994841237006e30c62';
      client_secret = '6766cdfb1223093895862376fb7d5fc45e7b7285';
      client_string = "client_id=" + client_id + "&client_secret=" + client_secret + "&per_page=30";
      return {
        request: (function(_this) {
          return function(config) {
            if (config.url.indexOf('api.github') > 0) {
              if (config.url.indexOf('?') > 0) {
                config.url = config.url + ("&" + client_string);
              } else {
                config.url = config.url + ("?" + client_string);
              }
            }
            return config;
          };
        })(this)
      };
    }

    return HttpRequestInterceptor;

  })();

  angular.module('app').factory('HttpRequestInterceptor', [HttpRequestInterceptor]);

}).call(this);
