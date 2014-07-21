class App extends App
  constructor: ->
    return [
      'ngRoute',
      'ngResource',
      'ngAnimate'
    ]

class Routes extends Config
  constructor: ($routeProvider) ->
    $routeProvider
    .when '/phones',
      templateUrl: 'list/list.html',
      controller: 'phoneListController'
    .when '/phones/:phoneId',
      templateUrl: 'detail/detail.html',
      controller: 'phoneDetailController'
    .otherwise
        redirectTo: '/phones'