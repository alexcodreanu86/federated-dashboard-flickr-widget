namespace('Pictures')

class Pictures.Display
  @getInput: ->
    $('[name=pictures-search]').val()

  @addImages: (images) ->
    imagesHtml = Pictures.Templates.renderImagesHtml(images)
    $('[data-id=pictures-output]').html(imagesHtml)

  @appendFormTo: (selector) ->
    formHtml = Pictures.Templates.renderForm()
    $(selector).html(formHtml)

  @logoSrc = "https://raw.githubusercontent.com/bwvoss/federated-dashboard-flickr-widget/master/lib/icon_10308/images.png"

  @generateLogo: (config) ->
    logoSrc = @logoSrc
    _.extend(config, {imgSrc: logoSrc})
    Pictures.Templates.renderLogo(config)

  @hideForm: ->
    $('[data-id=pictures-form]').hide()

  @showForm: ->
    $('[data-id=pictures-form]').show()
