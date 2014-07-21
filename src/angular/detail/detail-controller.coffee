class phoneDetail extends Controller
  constructor: ($scope, $routeParams, Phone) ->
    $scope.phone = Phone.get {phoneId: $routeParams.phoneId}, (phone) ->
      $scope.mainImageUrl = phone.images[0]
      return
    $scope.setImage = (imageUrl) ->
      $scope.mainImageUrl = imageUrl
      return
        
