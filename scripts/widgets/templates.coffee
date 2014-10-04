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
                  <div class='widget' data-name='widget-wrapper'>
                    <div class='widget-header' data-name='sortable-handle'>
                      <h2 class="widget-title">Pictures</h2>
                      <span class='widget-close' data-name='widget-close'>×</span>
                      <form class='widget-form' data-name='widget-form'>
                        <input name='widget-input' type='text' autofocus='true'>
                        <button data-name="form-button">Get pictures</button><br>
                      </form>
                    </div>
                    <div class="widget-body" data-name="widget-output"></div>
                  </div>
                """, {})
