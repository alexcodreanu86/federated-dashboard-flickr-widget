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
    $("#{@container} [name=pictures-search]").val()

  exitEditMode: ->
    @hideForm()
    @hideCloseWidget()

  hideForm: ->
    $("#{@container} [data-id=pictures-form]").hide(@animationSpeed)

  hideCloseWidget: ->
    $("#{@container} [data-id=pictures-close]").hide(@animationSpeed)

  enterEditMode: ->
    @showForm()
    @showCloseWidget()

  showForm: ->
    $("#{@container} [data-id=pictures-form]").show(@animationSpeed)

  showCloseWidget: ->
    $("#{@container} [data-id=pictures-close]").show(@animationSpeed)

  removeWidget: ->
    $(@container).remove()

  showImages: (images) ->
    imagesHtml = Pictures.Widgets.Templates.renderImagesHtml(images)
    $("#{@container} [data-id=pictures-output]").html(imagesHtml)
    @slider.startSliding()
