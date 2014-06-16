namespace('Pictures')

class Pictures.Controller
  @loadImages: (searchStr) ->
    Pictures.API.search(searchStr, Pictures.View.addImages)

  @setupWidgetIn: (container, apiKey) ->
    Pictures.API.key = apiKey
    Pictures.View.appendFormTo(container)
    @bind()

  @bind: ->
    $('[data-id=pictures-button]').click(=> @processInput(Pictures.View.getInput()))

  @processInput: (input) ->
    if @isValidInput(input)
      @loadImages(input)
    else
      @showInvalidInput()

  @isValidInput: (input) ->
    @isNotEmpty(input) && @hasOnlyValidCharacters(input)

  @isNotEmpty: (string) ->
    string.length != 0

  @hasOnlyValidCharacters: (string) ->
    !string.match(/[^\w\s]/)

  @showInvalidInput: ->
