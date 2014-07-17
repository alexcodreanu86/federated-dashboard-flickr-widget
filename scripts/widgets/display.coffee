namespace("Pictures.Widget")

class Pictures.Widgets.Display
  constructor: (container) ->
    @container = container

  setupWidget: ->
    widgetHtml = Pictures.Widgets.Templates.renderForm()
    $(@container).append(widgetHtml)

  getInput: ->
    $("#{@container} [name=pictures-search]").val()

  hideForm: ->
    $("#{@container} [data-id=pictures-form]").hide()

  showForm: ->
    $("#{@container} [data-id=pictures-form]").show()

  removeWidget: ->
    $("#{@container} [data-id=pictures-widget-wrapper]").remove()

  showImages: (images) ->
    imagesHtml = Pictures.Widgets.Templates.renderImagesHtml(images)
    $("#{@container} [data-id=pictures-output]").html(imagesHtml)
