class phone extends Factory
	constructor: ($resource) ->
		return $resource('phones/:phoneId.json', {}, {
			query: {method:'GET', params:{phoneId:'phones'}, isArray:true}
		});