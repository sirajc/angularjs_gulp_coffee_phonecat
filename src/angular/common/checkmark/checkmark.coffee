
checkmark = ->
    return (input) ->
      if(input) then '\u2713' else '\u2718'

textCheckmark = ->
    return (input) ->
      if(input) then 'Y' else 'X'

angular.module 'common.checkmark', []
  .filter('checkmark', checkmark)
  .filter('textCheckmark', textCheckmark)

