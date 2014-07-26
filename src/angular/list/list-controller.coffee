ThisIsNgAnnotateHack = 'IgnoreThisLine'

### @ngInject ###
PhoneListController = (Phone) ->
  @phones = Phone.query()
  @orderProp = 'age'
  return

angular.module 'app'
  .controller('PhoneListController', PhoneListController)

