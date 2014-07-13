class animateUp
  constructor: (element, className, done) ->
      if className != 'active' then return
      element.css {
        position: 'absolute',
        top: 500,
        left: 0,
        display: 'block'
      }
      jQuery element 
        .animate {
          top: 0
        }, done

      return (cancel) ->
          if cancel then element.stop(); return

class animateDown
  constructor: (element, className, done) ->
    if className != 'active' then return
    element.css {
      position: 'absolute',
      left: 0,
      top: 0
    }
    jQuery element 
      .animate {
        top: -500
      }, done

    return (cancel) ->
      if cancel then element.stop(); return

class phone extends Animation
  constructor: -> 
    return {
      addClass: animateUp,
      removeClass: animateDown
    }