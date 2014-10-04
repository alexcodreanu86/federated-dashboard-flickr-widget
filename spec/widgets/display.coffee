images =  [{url_n: "/spec/mockImages/url1.jpeg"}, {url_n: "/spec/mockImages/url2.jpeg"}, {url_n: "/spec/mockImages/url3.jpeg"}, {url_n: "/spec/mockImages/url4.jpeg"}, {url_n: "/spec/mockImages/url5.jpeg"}, {url_n: "/spec/mockImages/url6.jpeg"}]

setupOneContainer = ->
  setFixtures " <div data-id='widget-container-1'></div>"

setupTwoContainers = ->
  setFixtures """
    <div data-id='widget-container-1'></div>
    <div data-id='widget-container-2'></div>
  """

newDisplay = (container) ->
  new Pictures.Widgets.Display(container)

container1 = "[data-id=widget-container-1]"
container2 = "[data-id=widget-container-2]"

assertImageIsHidden= (imgNumber) ->
  image = $('img')[imgNumber]
  expect($(image).attr('style')).toEqual('display: none;')

assertImageIsDisplayed = (imgNumber) ->
  image = $('img')[imgNumber]
  expect($(image).attr('style')).not.toEqual('display: none;')

describe "Pictures.Widget.Display", ->
  it "stores the container it is initialized with", ->
    display = newDisplay(container2)
    expect(display.container).toEqual(container2)

  it "setupWidget is setting up the widget in it's container", ->
    display = newDisplay(container1)
    setupOneContainer()
    display.setupWidget()
    expect(container1).toContainElement('[data-name=widget-wrapper]')

  it "getInput returns the input in the field in it's own container", ->
    setupTwoContainers()
    display1 = newDisplay(container1)
    display2 = newDisplay(container2)
    display1.setupWidget()
    display2.setupWidget()
    $("#{container1} [name=widget-input]").val("text1")
    $("#{container2} [name=widget-input]").val("text2")
    expect(display1.getInput()).toEqual("text1")
    expect(display2.getInput()).toEqual("text2")

  it "removeWidget is removing the widget's content", ->
    setupOneContainer()
    display = newDisplay(container1)
    display.setupWidget()
    display.removeWidget()
    expect($(container1)).not.toContainElement("[data-name=widget-wrapper]")

  it "showImages displays the images on the screen", ->
    setupOneContainer()
    display = newDisplay(container1)
    display.setupWidget()
    display.showImages(images)
    expect($('img').length).toEqual(6)

  it 'showImages is sliding the pictures', ->
    setupOneContainer()
    jasmine.clock().install()
    display = newDisplay(container1)
    display.setupWidget()
    display.showImages(images)
    assertImageIsDisplayed(0)
    assertImageIsHidden(1)
    jasmine.clock().tick(3000 + 1)
    assertImageIsHidden(0)
    assertImageIsDisplayed(1)
    jasmine.clock().uninstall()
