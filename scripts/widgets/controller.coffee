namespace('Pictures.Widgets')

class Pictures.Widgets.Controller
  apiKey = undefined
  constructor: (container, key) ->
    apiKey = key
    @container = container
    @display = new Pictures.Widgets.Display(container)

  initialize: ->
    @display.setupWidget()
    @bind()

  getContainer: ->
    @container

  bind: ->
    $("#{@container} [data-id=pictures-button]").click(=> @processClickedButton())

  processClickedButton: ->
    input = @display.getInput()
    @processInput(input)

  processInput: (input) ->
    if @isValidInput(input)
      @loadImages(input)
    else
      @showInvalidInput()

  loadImages: (searchStr) ->
    data = {key: apiKey, searchString: searchStr}
    Pictures.Widgets.API.search(data, @display)

  isValidInput: (input) ->
    @isNotEmpty(input) && @hasOnlyValidCharacters(input)

  isNotEmpty: (string) ->
    string.length != 0

  hasOnlyValidCharacters: (string) ->
    !string.match(/[^\w\s]/)

  hideForm: ->
    @display.hideForm()

  showForm: ->
    @display.showForm()

  removeContent: ->
    @display.removeWidget()
