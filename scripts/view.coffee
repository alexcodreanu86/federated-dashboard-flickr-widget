namespace('Pictures')

class Pictures.View
  @getInput: ->
    $('[name=pictures-search]').val()

  @addImages: (images) ->
    imagesHtml = Pictures.Template.renderImagesHtml(images)
    $('[data-id=pictures-output]').html(imagesHtml)

  @appendFormTo: (selector) ->
    formHtml = Pictures.Template.renderForm()
    $(selector).html(formHtml)
