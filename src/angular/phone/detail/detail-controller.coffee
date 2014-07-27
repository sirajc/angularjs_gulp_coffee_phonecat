ThisIsNgAnnotateHack = 'IgnoreThisLine'

### @ngInject ###
PhoneDetailController = ($routeParams, Phone) ->
  @phone = Phone.get {phoneId: $routeParams.phoneId}, (phone) ->
    @mainImageUrl = phone.images[0]
    return

  @setImage = (imageUrl) ->
    @mainImageUrl = imageUrl
    return
  return

angular.module 'phone.detail', ['common.checkmark', 'phone.detail.directive']
  .controller 'PhoneDetailController', PhoneDetailController


