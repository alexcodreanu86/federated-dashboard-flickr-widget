namespace('Pictures.Widgets')

class Pictures.Widgets.Controller
  apiKey = undefined
  constructor: (container, key) ->
    apiKey = key
    @container = container
    @display = new Pictures.Widgets.Display(container)
    @activeStatus = false

  initialize: ->
    @display.setupWidget()
    @bind()
    @setAsActive()

  setAsActive: ->
    @activeStatus = true

  setAsInactive: ->
    @activeStatus = false

  isActive: ->
    @activeStatus

  getContainer: ->
    @container

  bind: ->
    $("#{@container} [data-id=pictures-button]").click(=> @processClickedButton())
    $("#{@container} [data-id=pictures-close]").click(=> @closeWidget())

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

  showInvalidInput: ->

  isValidInput: (input) ->
    @isNotEmpty(input) && @hasOnlyValidCharacters(input)

  isNotEmpty: (string) ->
    string.length != 0

  hasOnlyValidCharacters: (string) ->
    !string.match(/[^\w\s]/)

  closeWidget: ->
    @unbind()
    @removeContent()
    @setAsInactive()

  removeContent: ->
    @display.removeWidget()

  unbind: ->
    $("#{@container} [data-id=pictures-button]").unbind('click')
    $("#{@container} [data-id=pictures-close]").unbind('click')

  hideForm: ->
    @display.hideForm()

  showForm: ->
    @display.showForm()
