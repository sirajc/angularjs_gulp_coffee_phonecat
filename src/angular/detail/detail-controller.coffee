ThisIsNgAnnotateHack = 'IgnoreThisLine'

### @ngInject ###
PhoneDetailController = ($routeParams, Phone) ->
  detail = @
  detail.phone = Phone.get {phoneId: $routeParams.phoneId}, (phone) ->
    detail.mainImageUrl = phone.images[0]
    return

  detail.setImage = (imageUrl) ->
    detail.mainImageUrl = imageUrl
    return
  return

angular.module 'app'
  .controller 'PhoneDetailController', PhoneDetailController


