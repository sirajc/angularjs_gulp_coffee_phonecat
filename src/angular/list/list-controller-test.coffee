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
    phoneList = ->
      [{name: 'Nexus S'}, {name: 'Motorola DROID'}]
    
    beforeEach inject (_$httpBackend_, $rootScope, $controller) ->
      $httpBackend = _$httpBackend_
      $httpBackend.expectGET 'phones/phones.json' 
        .respond phoneList()
      scope = $rootScope.$new()
      ctrl = $controller 'PhoneListController', {$scope: scope}
      return

    it 'should create "phones" model with 2 phones fetched from xhr', -> 
      expect ctrl.phones
        .toEqualData []
      $httpBackend.flush()
      expect ctrl.phones
        .toEqualData phoneList()
      return

    it 'should set the default value of orderProp model', ->
      expect ctrl.orderProp
        .toBe 'age'
      return

    it 'should just pass', ->
      expect true
        .toBe true
      return
    return
    
  return