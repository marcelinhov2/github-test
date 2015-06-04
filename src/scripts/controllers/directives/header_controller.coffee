class Header extends Controller
  constructor: (
    @$scope
  ) -> do @init

  init: ->
    console.log 'header'