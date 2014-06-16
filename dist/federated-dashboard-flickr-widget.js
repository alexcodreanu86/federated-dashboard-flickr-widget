(function(underscore) {
  'use strict';

  window.namespace = function(string, obj) {
    var current = window,
        names = string.split('.'),
        name;

    while((name = names.shift())) {
      current[name] = current[name] || {};
      current = current[name];
    }

    underscore.extend(current, obj);

  };

}(window._));

(function() {
  namespace('Pictures');

  Pictures.API = (function() {
    function API() {}

    API.search = function(searchString, callback) {
      var flickr;
      flickr = new Flickr({
        api_key: "a48194703ae0d0d1055d6ded6c4c9869"
      });
      return flickr.photos.search({
        text: searchString,
        per_page: 6,
        extras: "url_n"
      }, function(err, response) {
        if (err) {
          throw new Error(err);
        }
        return callback(response.photos.photo);
      });
    };

    return API;

  })();

}).call(this);

(function() {
  namespace('Pictures');

  Pictures.Controller = (function() {
    function Controller() {}

    Controller.loadImages = function(searchStr) {
      return Pictures.API.search(searchStr, Pictures.View.addImages);
    };

    Controller.setupWidgetIn = function(container, apiKey) {
      Pictures.API.key = apiKey;
      Pictures.View.appendFormTo(container);
      return this.bind();
    };

    Controller.bind = function() {
      return $('[data-id=pictures-button]').click((function(_this) {
        return function() {
          return _this.processInput(Pictures.View.getInput());
        };
      })(this));
    };

    Controller.processInput = function(input) {
      if (this.isValidInput(input)) {
        return this.loadImages(input);
      } else {
        return this.showInvalidInput();
      }
    };

    Controller.isValidInput = function(input) {
      return this.isNotEmpty(input) && this.hasOnlyValidCharacters(input);
    };

    Controller.isNotEmpty = function(string) {
      return string.length !== 0;
    };

    Controller.hasOnlyValidCharacters = function(string) {
      return !string.match(/[^\w\s]/);
    };

    Controller.showInvalidInput = function() {};

    return Controller;

  })();

}).call(this);

(function() {
  namespace('Pictures');

  Pictures.Template = (function() {
    function Template() {}

    Template.renderImagesHtml = function(images) {
      return _.template("<div data-id=\"images\" id=\"flickr-images\">\n  <% for(var i = 0; i < images.length; i++){ %>\n    <img src=\"<%= images[i].url_n %> alt=\"<%= images[i].title %>\">\n  <% } %>\n</div>", {
        images: images
      });
    };

    Template.renderForm = function() {
      return _.template("<input name=\"pictures-search\" type=\"text\"><br>\n<button id=\"pictures\" data-id=\"pictures-button\">Get pictures</button><br>\n<div data-id=\"pictures-output\"></div>");
    };

    return Template;

  })();

}).call(this);

(function() {
  namespace('Pictures');

  Pictures.View = (function() {
    function View() {}

    View.getInput = function() {
      return $('[name=pictures-search]').val();
    };

    View.addImages = function(images) {
      var imagesHtml;
      imagesHtml = Pictures.Template.renderImagesHtml(images);
      return $('[data-id=pictures-output]').html(imagesHtml);
    };

    View.appendFormTo = function(selector) {
      var formHtml;
      formHtml = Pictures.Template.renderForm();
      return $(selector).html(formHtml);
    };

    return View;

  })();

}).call(this);
