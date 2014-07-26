ThisIsNgAnnotateHack = 'IgnoreThisLine'

### @ngInject ###
PhoneDetailController = ($scope, $routeParams, Phone) ->
  $scope.phone = Phone.get {phoneId: $routeParams.phoneId}, (phone) ->
    $scope.mainImageUrl = phone.images[0]
    return
  $scope.setImage = (imageUrl) ->
    $scope.mainImageUrl = imageUrl

    return

angular.module 'app'
  .controller 'PhoneDetailController', PhoneDetailController


