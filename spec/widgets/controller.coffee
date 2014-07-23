class Flickr
  photos: {
            search:  (options, callback) ->
              callback(null, photos: photo: [{url_n: "/spec/mockImages/url1.jpeg"}, {url_n: "/spec/mockImages/url2.jpeg"}, {url_n: "/spec/mockImages/url3.jpeg"}, {url_n: "/spec/mockImages/url4.jpeg"}, {url_n: "/spec/mockImages/url5.jpeg"}, {url_n: "/spec/mockImages/url6.jpeg"}])}

window.Flickr = Flickr

setupOneContainer = ->
  setFixtures "<div data-id='widget-container-1'></div>"

container = "[data-id=widget-container-1]"

newController = (container) ->
  new Pictures.Widgets.Controller(container, "1243")

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

  it "initialize is setting the widget as active", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    expect(controller.isActive()).toBe(true)

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
