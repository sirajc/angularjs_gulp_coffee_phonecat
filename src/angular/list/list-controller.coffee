class phoneList extends Controller
	constructor: ($scope, Phone) ->
		$scope.phones = Phone.query();
		$scope.orderProp = 'age';