describe 'Filters', ->
  beforeEach module 'common.checkmark'

  describe 'checkMark', ->
    it 'should convert true to \u2713',
      inject (checkmarkFilter) ->
        expect checkmarkFilter true
          .toBe '\u2713'
        return

    it 'should convert false to unicode \u2718',
      inject (checkmarkFilter) ->
        expect checkmarkFilter false
          .toBe '\u2718'
        return

    return

  describe 'textCheckmark', ->
    it 'should convert true to Y',
      inject (textCheckmarkFilter) ->
        expect textCheckmarkFilter true
          .toBe 'Y'
        return

    it 'should convert false to X',
      inject (textCheckmarkFilter) ->
        expect textCheckmarkFilter false
          .toBe 'X'
        return

    return

  return