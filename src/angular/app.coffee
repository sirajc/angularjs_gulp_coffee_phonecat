
angular.module 'phonecatApp', [
  'ngRoute',
  'ngResource',
  'ngAnimate',
  'phone.detail',
  'phone.list'
]

### @ngInject ###
Routes = ($routeProvider) ->
    $routeProvider
    .when '/phones',
      templateUrl: 'phone/list/list.html',
      controller: 'PhoneListController as phoneList'
    .when '/phones/:phoneId',
      templateUrl: 'phone/detail/detail.html',
      controller: 'PhoneDetailController as phoneDetail'
    .otherwise
        redirectTo: '/phones'

angular.module 'phonecatApp'
  .config(Routes)
