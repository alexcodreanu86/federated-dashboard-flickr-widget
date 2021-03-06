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

describe "Pictures.Widgets.Controller", ->
  describe '#initialize', ->
    it "sets widget up in its container", ->
      setupOneContainer()
      controller = newController(container)
      controller.initialize()
      expect($(container)).not.toBeEmpty()

    it "binds the controller", ->
      controller = newController(container)
      spy = spyOn(controller, 'bind')
      controller.initialize()
      expect(spy).toHaveBeenCalled()

    it "displays data for the default value", ->
      controller = newController(container)
      spy = spyOn(controller, 'displayDefault')
      controller.initialize()
      expect(spy).toHaveBeenCalled()

    it "sets the widget as active", ->
      setupOneContainer()
      controller = newController(container)
      controller.initialize()
      expect(controller.isActive()).toBe(true)

  describe '#displayDefault', ->
    it "loads data data when there is a default value", ->
      controller = newController(container, defaultValue)
      spy = spyOn(Pictures.Widgets.API, 'search')
      controller.displayDefault()
      expect(spy).toHaveBeenCalledWith(requestData, controller.display)

    it "does NOT load data when no default value is provided", ->
      controller = newController(container)
      spy = spyOn(Pictures.Widgets.API, 'search')
      controller.displayDefault()
      expect(spy).not.toHaveBeenCalled()

  describe '#bind', ->
    it "gets pictures and displays them when pictures button is clicked", ->
      setupOneContainer()
      controller = newController(container)
      controller.initialize()
      $('[name=widget-input]').val('bikes')
      $("#{container} [data-name=form-button]").click()
      expect($('img').length).toEqual(6)

    it "removes the widget when close-widget button is clicked", ->
      setupOneContainer()
      controller = newController(container)
      controller.initialize()
      $("#{container} [data-name=widget-close]").click()
      expect(container).not.toBeInDOM()

  describe '#unbind', ->
    it 'unbinds the pictures button click processing', ->
      setupOneContainer()
      controller = newController(container)
      controller.initialize()
      spy = spyOn $.prototype, 'unbind'
      controller.unbind()
      expect(spy).toHaveBeenCalledWith('submit')

    it "unbinds close widget button processing", ->
      setupOneContainer()
      controller = newController(container)
      controller.initialize()
      controller.unbind()
      $("#{container} [data-name=widget-close]").click()
      expect($(container)).not.toBeEmpty()

  describe '#closeWidget', ->
    it 'unbinds the controller', ->
      setupOneContainer()
      controller = newController(container)
      spy = spyOn(controller, 'unbind')
      controller.closeWidget()
      expect(spy).toHaveBeenCalled()

    it 'sets the widget as inactive', ->
      setupOneContainer()
      controller = newController(container)
      controller.initialize()
      controller.closeWidget()
      expect(controller.isActive()).toBe(false)

  it "removeContent is removing the widget's content", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    controller.removeContent()
    expect($(container)).not.toContainElement("[data-name=widget-wrapper]")

  describe "loadImages", ->
    newRefreshController = (container, refreshRate) ->
      new Pictures.Widgets.Controller({container: container, key: "1243", refreshRate: refreshRate})

    oneMinute   = 60 * 1000
    controller  = undefined
    spy         = undefined

    beforeEach ->
      controller = newRefreshController(container, 50)
      controller.setAsActive()
      spy = spyOn(Pictures.Widgets.API, 'search')
      jasmine.clock().install()

    afterEach ->
      jasmine.clock().uninstall()

    it "refreshes the informations when refreshInterval is provided", ->
      controller.loadImages('some input')
      expect(spy.calls.count()).toEqual(1)
      jasmine.clock().tick(oneMinute)
      expect(spy.calls.count()).toEqual(2)

    it "will not refresh if the widget is closed", ->
      controller.loadImages('some input')
      expect(spy.calls.count()).toEqual(1)
      controller.closeWidget()
      jasmine.clock().tick(oneMinute)
      expect(spy.calls.count()).toEqual(1)

    it "will not refresh if no refreshRate is specified", ->
      controller = newRefreshController(container, undefined)
      controller.setAsActive()
      controller.loadImages('some input')
      expect(spy.calls.count()).toEqual(1)
      jasmine.clock().tick(oneMinute)
      expect(spy.calls.count()).toEqual(1)

    it "will refresh only for the new search", ->
      controller.loadImages('some input')
      expect(spy).toHaveBeenCalledWith({key: "1243", searchString: 'some input'}, controller.display)
      controller.loadImages('other input')
      expect(spy.calls.argsFor(1)[0]).toEqual({key: "1243", searchString: 'other input'})
      jasmine.clock().tick(oneMinute)
      expect(spy.calls.argsFor(2)[0]).toEqual({key: "1243", searchString: 'other input'})
      expect(spy.calls.count()).toEqual(3)
