namespace('Pictures')

class Pictures.Template
  @renderImagesHtml: (images) ->
    _.template( """
                  <div data-id="images" id="flickr-images">
                    <% for(var i = 0; i < images.length; i++){ %>
                      <img src="<%= images[i].url_n %> alt="<%= images[i].title %>">
                    <% } %>
                  </div>
                """, {images: images})

  @renderForm: ->
    _.template("""
                <input name="pictures-search" type="text"><br>
                <button id="pictures" data-id="pictures-button">Get pictures</button><br>
                <div data-id="pictures-output"></div>
               """)
