PhoneSpec = ->
  restrict: 'E'
  templateUrl: 'phone/detail/phoneSpec.tpl.html'
  scope: {
    title: '@'
    listing: '='
  }

angular.module 'phone.detail.directive', []
.directive('phoneSpec', PhoneSpec)
