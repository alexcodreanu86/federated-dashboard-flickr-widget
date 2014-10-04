namespace('Pictures.Widgets')

class Pictures.Widgets.Slider
  constructor: (container, slideInterval) ->
    @container = container
    @slideInterval = slideInterval

  startSliding: ->
    images = $("#{@container} [data-name=widget-output] img")
    images.hide()
    $(images[0]).show()
    @slideImages(images)

  slideImages: (images) ->
    @stopSliding() if @slide
    currentNumber = 0
    @slide = setInterval( =>
      currentNumber = @getNextImageNumber(images.length, currentNumber)
      images.hide()
      $(images[currentNumber]).show()
    , @slideInterval
    )

  stopSliding: ->
    clearInterval(@slide)

  getNextImageNumber: (length, currentNumber) ->
    if (currentNumber + 1) >= length
      0
    else
      currentNumber + 1
