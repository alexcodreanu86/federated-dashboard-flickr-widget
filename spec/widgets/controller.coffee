container     = "[data-id=widget-container-1]"
key           = "1243"
defaultValue  = "bikes"
requestData   = {key: key, searchString: defaultValue}

class Flickr
  photos: {
            search:  (options, callback) ->
              callback(null, photos: photo: [{url_n: "/spec/mockImages/url1.jpeg"}, {url_n: "/spec/mockImages/url2.jpeg"}, {url_n: "/spec/mockImages/url3.jpeg"}, {url_n: "/spec/mockImages/url4.jpeg"}, {url_n: "/spec/mockImages/url5.jpeg"}, {url_n: "/spec/mockImages/url6.jpeg"}])}

window.Flickr = Flickr

setupOneContainer = ->
  setFixtures "<div data-id='widget-container-1'></div>"

container = "[data-id=widget-container-1]"

newController = (container, value) ->
  new Pictures.Widgets.Controller({container: container, key: "1243", defaultValue:value})

inputInto = (name, value)->
  $("[name=#{name}]").val(value)

describe "Pictures.Widgets.Controller", ->
  it "stores the container that it is initialized with", ->
    controller = newController(container)
    expect(controller.getContainer()).toEqual(container)

  it "stores a new instance of Pictures.Widget.Display when instantiated", ->
    controller = newController(container)
    expect(controller.display).toBeDefined()

  it "initialize sets widget up in its container", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    expect($(container)).not.toBeEmpty()

  it "initialize is binding the controller", ->
    controller = newController(container)
    spy = spyOn(controller, 'bind')
    controller.initialize()
    expect(spy).toHaveBeenCalled()

  it "initialize is trying to display data for the default value", ->
    controller = newController(container)
    spy = spyOn(controller, 'displayDefault')
    controller.initialize()
    expect(spy).toHaveBeenCalled()

  it "initialize is setting the widget as active", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    expect(controller.isActive()).toBe(true)

  it "displayDefault is loading data data when there is a default value", ->
    controller = newController(container, defaultValue)
    spy = spyOn(Pictures.Widgets.API, 'search')
    controller.displayDefault()
    expect(spy).toHaveBeenCalledWith(requestData, controller.display)

  it "displayDefault doesn't do anything when no default value is provided", ->
    controller = newController(container)
    spy = spyOn(Pictures.Widgets.API, 'search')
    controller.displayDefault()
    expect(spy).not.toHaveBeenCalled()

  it "bind gets pictures and displays them when pictures button is clicked", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    inputInto('pictures-search', 'bikes')
    $("#{container} [data-id=pictures-button]").click()
    expect($('img').length).toEqual(6)

  it "bind removes the widget when close-widget button is clicked", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    $("#{container} [data-id=pictures-close]").click()
    expect(container).not.toBeInDOM()

  it 'unbind is unbinding the pictures button click processing', ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    inputInto('pictures-search', 'bikes')
    controller.unbind()
    $("#{container} [data-id=pictures-button]").click()
    expect($('img').length).toEqual(0)

  it "unbind is unbinding close widget button processing", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    controller.unbind()
    $("#{container} [data-id=pictures-close]").click()
    expect($(container)).not.toBeEmpty()

  it 'closeWidget is unbinding the controller', ->
    setupOneContainer()
    controller = newController(container)
    spy = spyOn(controller, 'unbind')
    controller.closeWidget()
    expect(spy).toHaveBeenCalled()

  it 'closeWidget is setting the widget as inactive', ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    controller.closeWidget()
    expect(controller.isActive()).toBe(false)

  it "hideForm is hiding the form", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    controller.hideForm()
    expect($("#{container} [data-id=pictures-form]").attr('style')).toEqual('display: none;')

  it "showForm is showing the form", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    controller.hideForm()
    controller.showForm()
    expect($("#{container} [data-id=pictures-form]").attr('style')).not.toEqual('display: none;')

  it "removeContent is removing the widget's content", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    controller.removeContent()
    expect($(container)).not.toContainElement("[data-id=pictures-widget-wrapper]")

  describe "loadImages", ->
    newRefreshController = (container, refreshRate) ->
      new Pictures.Widgets.Controller({container: container, key: "1243", refreshRate: refreshRate})

    oneMinute = 60 * 1000

    it "refreshes the informations when refreshInterval is provided", ->
      controller = newRefreshController(container, 50)
      controller.setAsActive()
      spy = spyOn(Pictures.Widgets.API, 'search')
      jasmine.clock().install()
      controller.loadImages('some input')
      expect(spy.calls.count()).toEqual(1)
      jasmine.clock().tick(oneMinute)
      expect(spy.calls.count()).toEqual(2)
      jasmine.clock().uninstall()

    it "will not refresh if the widget is closed", ->
      controller = newRefreshController(container, 50)
      controller.setAsActive()
      spy = spyOn(Pictures.Widgets.API, 'search')
      jasmine.clock().install()
      controller.loadImages('some input')
      expect(spy.calls.count()).toEqual(1)
      controller.closeWidget()
      jasmine.clock().tick(oneMinute)
      expect(spy.calls.count()).toEqual(1)
      jasmine.clock().uninstall()

    it "will refresh only for the new search", ->
      controller = newRefreshController(container, 50)
      controller.setAsActive()
      spy = spyOn(Pictures.Widgets.API, 'search')
      jasmine.clock().install()
      controller.loadImages('some input')
      expect(spy).toHaveBeenCalledWith({key: "1243", searchString: 'some input'}, controller.display)
      controller.loadImages('other input')
      expect(spy.calls.argsFor(1)[0]).toEqual({key: "1243", searchString: 'other input'})
      jasmine.clock().tick(oneMinute)
      expect(spy.calls.argsFor(2)[0]).toEqual({key: "1243", searchString: 'other input'})
      expect(spy.calls.count()).toEqual(3)
      jasmine.clock().uninstall()
