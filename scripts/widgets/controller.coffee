namespace('Pictures.Widgets')

class Pictures.Widgets.Controller
  apiKey = undefined
  constructor: (settings) ->
    apiKey        = settings.key
    @container    = settings.container
    @display      = new Pictures.Widgets.Display(@container, settings.animationSpeed, settings.slideSpeed)
    @activeStatus = false
    @defaultValue = settings.defaultValue
    @refreshRate  = settings.refreshRate

  initialize: ->
    @display.setupWidget()
    @bind()
    @displayDefault()
    @setAsActive()

  displayDefault: ->
    if @defaultValue
      @loadImages(@defaultValue)

  setAsActive: ->
    @activeStatus = true

  setAsInactive: ->
    @activeStatus = false

  isActive: ->
    @activeStatus

  getContainer: ->
    @container

  bind: ->
    $("#{@container} [data-name=widget-form]").on 'submit',  (e) =>
      e.preventDefault()
      @processClickedButton()

    $("#{@container} [data-name=widget-close]").on 'click', => @closeWidget()

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
    if @refreshRate
      @clearActiveTimeout()
      @refreshImages(searchStr)

  clearActiveTimeout: ->
    clearTimeout(@timeout) if @timeout

  refreshImages: (searchStr) ->
    @timeout = setTimeout(=>
      @loadImages(searchStr) if @isActive()
    , @refreshRate * 1000)

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
    $("#{@container} [data-name=widget-form]").unbind('submit')
    $("#{@container} [data-name=widget-close]").unbind('click')

  exitEditMode: ->
    @display.exitEditMode()

  enterEditMode: ->
    @display.enterEditMode()
