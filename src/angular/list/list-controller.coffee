ThisIsNgAnnotateHack = 'IgnoreThisLine'

### @ngInject ###
PhoneListController = ($scope, Phone) ->
  $scope.phones = Phone.query()
  $scope.orderProp = 'age'
  return

angular.module 'app'
  .controller('PhoneListController', PhoneListController)

