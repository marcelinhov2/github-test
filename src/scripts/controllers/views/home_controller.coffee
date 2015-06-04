class Home extends Controller
  constructor: (
    @$scope
  ) -> do @init

  init: ->
    console.log 'home'