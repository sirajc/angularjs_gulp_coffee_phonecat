describe 'Phone Detail Controllers', ->
  beforeEach ->
    this.addMatchers
      toEqualData: (expected) ->
        angular.equals(this.actual, expected)
    return

  beforeEach module 'app'

  describe 'Detail Controller', ->
    scope = {}
    $httpBackend = {}
    ctrl = {}
    xyzPhoneData = ->
      { name: 'phone xyz',
      images: ['image/url1.png', 'image/url1.png'] }

    beforeEach inject (_$httpBackend_, $rootScope, $routeParams, $controller) ->
      $httpBackend = _$httpBackend_
      $httpBackend
        .expectGET 'phones/xyz.json'
          .respond xyzPhoneData()
      $routeParams.phoneId = 'xyz'
      scope = $rootScope.$new()
      ctrl = $controller 'phoneDetailController', $scope: scope
      return;


    it 'should fetch phone detail', ->
      expect scope.phone
        .toEqualData {}
      $httpBackend.flush()
      expect scope.phone
        .toEqualData xyzPhoneData()
      return
    return
  return