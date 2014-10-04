namespace("Pictures.Widgets")

class Pictures.Widgets.API
  @search: (data, displayer) ->
    apiKey = data.key
    flickr =  new Flickr(
      api_key: apiKey
    )
    flickr.photos.search({
        text: data.searchString,
        per_page: 6,
        thumbnail_size: 'Medium',
        extras: "url_n"
      }, (err, response) ->
        if err
          throw new Error(err)
        displayer.showImages(response.photos.photo)
    )
