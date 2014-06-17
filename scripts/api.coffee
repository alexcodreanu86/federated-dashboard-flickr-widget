namespace('Pictures')

class Pictures.API
  @search: (searchString, callback)->
    apiKey = @key
    flickr =  new Flickr(
      api_key: apiKey
    )
    flickr.photos.search({
        text: searchString,
        per_page: 6,
        extras: "url_n"
      }, (err, response) ->
        if err
          throw new Error(err)
        callback(response.photos.photo)
    )

