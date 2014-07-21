describe 'service', ->
  beforeEach module 'app'

  it 'check the existence of Phone factory', inject (Phone) ->
    expect Phone
      .toBeDefined()
