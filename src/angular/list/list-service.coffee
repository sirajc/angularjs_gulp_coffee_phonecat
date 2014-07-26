ThisIsNgAnnotateHack = 'IgnoreThisLine'

### @ngInject ###
Phone = ($resource) ->
    return $resource('phones/:phoneId.json', {}, {
      query: {method:'GET', params:{phoneId:'phones'}, isArray:true}
  });

angular.module 'app'
  .factory('Phone', Phone)


