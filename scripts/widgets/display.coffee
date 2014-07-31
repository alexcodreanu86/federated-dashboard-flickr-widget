namespace("Pictures.Widget")

class Pictures.Widgets.Display
  constructor: (container) ->
    @container = container
    @slider = new Pictures.Widgets.Slider(@container, 3000)

  setupWidget: ->
    widgetHtml = Pictures.Widgets.Templates.renderForm()
    $(@container).append(widgetHtml)

  getInput: ->
    $("#{@container} [name=pictures-search]").val()

  exitEditMode: ->
    @hideForm()
    @hideCloseWidget()

  hideForm: ->
    $("#{@container} [data-id=pictures-form]").hide()

  hideCloseWidget: ->
    $("#{@container} [data-id=pictures-close]").hide()

  enterEditMode: ->
    @showForm()
    @showCloseWidget()

  showForm: ->
    $("#{@container} [data-id=pictures-form]").show()

  showCloseWidget: ->
    $("#{@container} [data-id=pictures-close]").show()

  removeWidget: ->
    $(@container).remove()

  showImages: (images) ->
    imagesHtml = Pictures.Widgets.Templates.renderImagesHtml(images)
    $("#{@container} [data-id=pictures-output]").html(imagesHtml)
    @slider.startSliding()
