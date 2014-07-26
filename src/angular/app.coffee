
angular.module 'app', [
  'ngRoute',
  'ngResource',
  'ngAnimate'
]

### @ngInject ###
Routes = ($routeProvider) ->
    $routeProvider
    .when '/phones',
      templateUrl: 'list/list.html',
      controller: 'PhoneListController'
    .when '/phones/:phoneId',
      templateUrl: 'detail/detail.html',
      controller: 'PhoneDetailController'
    .otherwise
        redirectTo: '/phones'

angular.module 'app'
  .config(Routes)
