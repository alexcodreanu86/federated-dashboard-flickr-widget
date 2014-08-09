namespace('Pictures')

class Pictures.Display
  @generateLogo: (config) ->
    "<i class=\"fa fa-camera #{config.class}\" data-id=\"#{config.dataId}\"></i>"
