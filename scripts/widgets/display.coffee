namespace("Pictures.Widget")

class Pictures.Widgets.Display
  constructor: (container, animationSpeed, slideSpeed) ->
    @container = container
    @animationSpeed = animationSpeed
    @slider = new Pictures.Widgets.Slider(@container, slideSpeed || 3000)

  setupWidget: ->
    widgetHtml = Pictures.Widgets.Templates.renderForm()
    $(@container).append(widgetHtml)

  getInput: ->
    $("#{@container} [name=widget-input]").val()

  removeWidget: ->
    $(@container).remove()

  showImages: (images) ->
    imagesHtml = Pictures.Widgets.Templates.renderImagesHtml(images)
    $("#{@container} [data-name=widget-output]").html(imagesHtml)
    @slider.startSliding()
