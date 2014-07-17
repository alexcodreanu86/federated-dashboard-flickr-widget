namespace('Pictures')

class Pictures.Templates
  @renderLogo: (imgData) ->
    _.template("<img src='<%= imgData['imgSrc'] %>' data-id='<%= imgData['dataId'] %>' style='width: <%= imgData['width'] %>px'/>", {imgData: imgData})
