class checkmark extends Filter
	constructor: ->
		return (input) ->
			if(input) then '\u2713' else '\u2718'

class textCheckmark extends Filter
  constructor: ->
    return (input) ->
      if(input) then 'Y' else 'X'