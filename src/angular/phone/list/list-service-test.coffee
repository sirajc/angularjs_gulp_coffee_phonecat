describe 'service', ->
  beforeEach module 'phonecatApp'

  it 'check the existence of Phone factory', inject (Phone) ->
    expect Phone
      .toBeDefined()
