namespace("Pictures.Widgets")

class Pictures.Widgets.Templates
  @renderImagesHtml: (images) ->
    _.template( """
                  <div data-id="images" id="flickr-images">
                    <% for(var i = 0; i < images.length; i++){ %>
                      <img src="<%= images[i].url_n %>" alt="<%= images[i].title %>">
                    <% } %>
                  </div>
                """, {images: images})

  @renderForm: ->
    _.template("""
                <div class='widget' data-id='pictures-widget-wrapper'>
                  <div class="widget-header">
                    <h2 class="widget-title">Pictures</h2>
                    <div class="widget-form" data-id='pictures-form'>
                      <input name="pictures-search" type="text">
                      <button id="pictures" data-id="pictures-button">Get pictures</button><br>
                    </div>
                  </div>
                  <div class="widget-body" data-id="pictures-output"></div>
                </div>
               """)
