namespace('Pictures')

class Pictures.Display
  @logoSrc = "https://raw.githubusercontent.com/bwvoss/federated-dashboard-flickr-widget/master/lib/icon_10308/images.png"

  @generateLogo: (config) ->
    logoSrc = @logoSrc
    _.extend(config, {imgSrc: logoSrc})
    Pictures.Templates.renderLogo(config)
