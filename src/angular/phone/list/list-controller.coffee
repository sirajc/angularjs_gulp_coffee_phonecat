ThisIsNgAnnotateHack = 'IgnoreThisLine'

### @ngInject ###
PhoneListController = (Phone) ->
  @phones = Phone.query()
  @orderProp = 'age'
  return

angular.module 'phone.list', ['list.animation', 'list.service']
  .controller('PhoneListController', PhoneListController)

