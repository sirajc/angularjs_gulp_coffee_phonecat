PhoneList = ->
  restrict: 'E'
  templateUrl: 'phone/list/phones.tpl.html'
  replace: true
  scope: {
    phonelist: '='
    query: '='
    order: '='
  }

angular.module 'phone.directive', []
  .directive('phoneList', PhoneList)
