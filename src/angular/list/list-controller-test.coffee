describe 'Phone List Controllers', ->
  beforeEach ->
    this.addMatchers
      toEqualData: (expected) ->
        angular.equals(this.actual, expected)
    return
  
  beforeEach module 'app'

  describe 'phoneListController', ->
    scope = {}
    ctrl = {}
    $httpBackend = {}
    
    beforeEach inject (_$httpBackend_, $rootScope, $controller) ->
      $httpBackend = _$httpBackend_
      $httpBackend.expectGET 'phones/phones.json' 
        .respond [{name: 'Nexus S'}, {name: 'Motorola DROID'}]
      scope = $rootScope.$new()
      ctrl = $controller 'phoneListController', {$scope: scope}
      return

    it 'should create "phones" model with 2 phones fetched from xhr', -> 
      expect scope.phones 
        .toEqualData []
      $httpBackend.flush()
      expect scope.phones 
        .toEqualData [{name: 'Nexus S'}, {name: 'Motorola DROID'}]
      return

    it 'should set the default value of orderProp model', ->
      expect scope.orderProp 
        .toBe 'age'
      return

    it 'should just pass', ->
      expect true
        .toBe true
      return
    return
    
  return