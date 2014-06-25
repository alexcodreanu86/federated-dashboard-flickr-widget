namespace('Pictures')

class Pictures.Controller
  @loadImages: (searchStr) ->
    Pictures.API.search(searchStr, Pictures.Display.addImages)

  @setupWidgetIn: (container, apiKey) ->
    Pictures.API.key = apiKey
    Pictures.Display.appendFormTo(container)
    @bind()

  @bind: ->
    $('[data-id=pictures-button]').click(=> @processInput(Pictures.Display.getInput()))

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
