class Flickr
  photos: {
            search:  (options, callback) ->
              callback(null, photos: photo: [{url_n: "/spec/mockImages/url1.jpeg"}, {url_n: "/spec/mockImages/url2.jpeg"}, {url_n: "/spec/mockImages/url3.jpeg"}, {url_n: "/spec/mockImages/url4.jpeg"}, {url_n: "/spec/mockImages/url5.jpeg"}, {url_n: "/spec/mockImages/url6.jpeg"}])}

window.Flickr = Flickr

resetWidgetsContainer = ->
  Pictures.Controller.widgets = []

setSandbox = ->
  setFixtures(sandbox())

setupTwoContainers = ->
  setFixtures """
    <div data-id='widget-container-1'></div>
    <div data-id='widget-container-2'></div>
  """

container1 = "[data-id=widget-container-1]"
container2 = "[data-id=widget-container-2]"

describe "Pictures.Controller", ->
  it "setupWidgetIn is setting up widget in the desired element", ->
    setFixtures(sandbox())
    Pictures.Controller.setupWidgetIn('#sandbox', "123456")
    expect($('#sandbox')).toContainElement('[name=pictures-search]')
    expect($('#sandbox')).toContainElement('[data-id=pictures-button]')
    expect($('#sandbox')).toContainElement('[data-id=pictures-output]')

  it "widgets container is empty on initialization", ->
    resetWidgetsContainer()
    container = Pictures.Controller.getWidgets()
    expect(container.length).toBe(0)

  it "setupWidgetIn is setting up a widget instance in the desired element", ->
    resetWidgetsContainer()
    setSandbox()
    Pictures.Controller.setupWidgetIn('#sandbox', "123456")
    html = $('#sandbox')
    expect(html).toContainElement('[name=pictures-search]')
    expect(html).toContainElement('[data-id=pictures-button]')
    expect(html).toContainElement('[data-id=pictures-output]')

  it "setupWidgetIn is adding the initialized widget to the widgets container", ->
    resetWidgetsContainer()
    setSandbox()
    Pictures.Controller.setupWidgetIn('#sandbox', "123456")
    expect(Pictures.Controller.getWidgets().length).toEqual(1)

  it "hideForms is hiding the forms of all the widgets that are initialized", ->
    resetWidgetsContainer()
    setupTwoContainers()
    Pictures.Controller.setupWidgetIn(container1, "123456")
    Pictures.Controller.setupWidgetIn(container2, "123456")
    Pictures.Controller.hideForms()
    expect($("#{container1} [data-id=pictures-form]").attr('style')).toEqual('display: none;')
    expect($("#{container2} [data-id=pictures-form]").attr('style')).toEqual('display: none;')

  it "showForms is showing the forms of all the widgets that are initialized", ->
    resetWidgetsContainer()
    setupTwoContainers()
    Pictures.Controller.setupWidgetIn(container1, "123456")
    Pictures.Controller.setupWidgetIn(container2, "123456")
    Pictures.Controller.hideForms()
    Pictures.Controller.showForms()
    expect($("#{container1} [data-id=pictures-form]").attr('style')).not.toEqual('display: none;')
    expect($("#{container2} [data-id=pictures-form]").attr('style')).not.toEqual('display: none;')

  it "closeWidgetInContainer will remove the widget from the widgets container", ->
    resetWidgetsContainer()
    setupTwoContainers()
    Pictures.Controller.setupWidgetIn(container1, "123456")
    Pictures.Controller.setupWidgetIn(container2, "123456")
    Pictures.Controller.closeWidgetInContainer(container1)
    expect(Pictures.Controller.getWidgets().length).toEqual(1)

  it "closeWidgetInContainer will eliminate the widget from the given container", ->
    resetWidgetsContainer()
    setupTwoContainers()
    Pictures.Controller.setupWidgetIn(container1, "123456")
    Pictures.Controller.setupWidgetIn(container2, "123456")
    Pictures.Controller.closeWidgetInContainer(container1)
    expect($("#{container1} [data-id=pictures-form]")).not.toBeInDOM()
    expect($("#{container2} [data-id=pictures-form]")).toBeInDOM()

  it "allWidgetsExecute is removing the inactive widgets", ->
    resetWidgetsContainer()
    setupTwoContainers()
    Pictures.Controller.setupWidgetIn(container1, "123456")
    Pictures.Controller.setupWidgetIn(container2, "123456")
    Pictures.Controller.widgets[0].setAsInactive()
    Pictures.Controller.allWidgetsExecute('hideForm')
    expect(Pictures.Controller.widgets.length).toBe(1)

