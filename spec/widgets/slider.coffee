images =  [{url_n: "/spec/mockImages/url1.jpeg"}, {url_n: "/spec/mockImages/url2.jpeg"}, {url_n: "/spec/mockImages/url3.jpeg"}, {url_n: "/spec/mockImages/url4.jpeg"}, {url_n: "/spec/mockImages/url5.jpeg"}, {url_n: "/spec/mockImages/url6.jpeg"}]

setupOneContainer = ->
  setFixtures " <div data-id='widget-container'></div>"


newSlider =  (container, slideInterval) ->
  new Pictures.Widgets.Slider(container, slideInterval)

container = '[data-id=widget-container]'

slideInterval = 3000

displayImages = ->
  setupOneContainer()
  display = newDisplay(container)
  display.setupWidget()
  display.showImages(images)

newDisplay = (container) ->
  new Pictures.Widgets.Display(container)

assertImageIsHidden= (imgNumber) ->
  image = $('img')[imgNumber]
  expect($(image).attr('style')).toEqual('display: none;')

assertImageIsDisplayed = (imgNumber) ->
  image = $('img')[imgNumber]
  expect($(image).attr('style')).not.toEqual('display: none;')




describe 'Pictures.Widgets.Slider', ->
  it 'stores the container that it gets initialized with', ->
    expect(newSlider(container).container).toEqual(container)

  it 'stores the slideInterval that it gets initialized with', ->
    expect(newSlider(container, slideInterval).slideInterval).toEqual(slideInterval)

  it 'getNextImageNumber returns 1 in case current Number is 0', ->
    slider = newSlider(container, slideInterval)
    expect(slider.getNextImageNumber(6,0)).toBe(1)

  it 'getNextImageNumber returns 0 in case current number is one smaller than number of images', ->
    slider = newSlider(container, slideInterval)
    expect(slider.getNextImageNumber(6, 5)).toBe(0)

  it 'slideImages is hiding all the images except the first one on start', ->
    displayImages()
    slider = newSlider(container, slideInterval)
    slider.startSliding()
    assertImageIsDisplayed(0)
    assertImageIsHidden(1)
    assertImageIsHidden(2)
    assertImageIsHidden(3)
    assertImageIsHidden(4)
    assertImageIsHidden(5)

  it 'slideImages is displaying the second image after the slideInterval time passes', ->
    jasmine.clock().install()
    displayImages()
    slider = newSlider(container, slideInterval)
    slider.startSliding()
    assertImageIsHidden(1)
    jasmine.clock().tick(slideInterval + 1)
    assertImageIsDisplayed(1)
    jasmine.clock().uninstall()

  it 'slideImages is hiding the first image after the slideInterval time passes', ->
    jasmine.clock().install()
    displayImages()
    slider = newSlider(container, slideInterval)
    slider.startSliding()
    assertImageIsDisplayed(0)
    jasmine.clock().tick(slideInterval + 1)
    assertImageIsHidden(0)
    jasmine.clock().uninstall()
