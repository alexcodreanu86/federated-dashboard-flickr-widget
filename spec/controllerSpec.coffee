class Flickr
  photos: {
            search:  (options, callback) ->
              callback(null, photos: photo: [{url_n: "/spec/mockImages/url1.jpeg"}, {url_n: "/spec/mockImages/url2.jpeg"}, {url_n: "/spec/mockImages/url3.jpeg"}, {url_n: "/spec/mockImages/url4.jpeg"}, {url_n: "/spec/mockImages/url5.jpeg"}, {url_n: "/spec/mockImages/url6.jpeg"}])}

window.Flickr = Flickr

setupFixtures = ->
  setFixtures """
                <input name="pictures-search" type="text"><br>
                <button data-id="pictures-button">Load Pictures</button>
                <div data-id='pictures-output'></div>
              """
inputInto = (name, value)->
  $("[name=#{name}]").val(value)

describe "Pictures.Controller", ->
  it "bind gets pictures and displays them", ->
    setupFixtures()
    Pictures.Controller.bind()
    inputInto('pictures-search', 'bikes')
    $('[data-id=pictures-button]').click()
    expect($('img').length).toEqual(6)

  it "isValidInput returns true if the string is not empty", ->
    expect(Pictures.Controller.isValidInput("some text")).toBe(true)

  it "isValidInput returns false if the string is empty", ->
    expect(Pictures.Controller.isValidInput("")).toBe(false)

  it "isValidInput returns false if the string includes non word characters", ->
    expect(Pictures.Controller.isValidInput("#^&asdasd")).toBe(false)

  it "processInput loads images if input is valid", ->
    spy = spyOn(Pictures.Controller, 'loadImages')
    Pictures.Controller.processInput('bikes')
    expect(spy).toHaveBeenCalledWith('bikes')

  it "setupWidgetIn is setting up widget in the desired element", ->
    setFixtures(sandbox())
    Pictures.Controller.setupWidgetIn('#sandbox', "123456")
    html = $('#sandbox')
    expect(html).toContainElement('[name=pictures-search]')
    expect(html).toContainElement('[data-id=pictures-button]')
    expect(html).toContainElement('[data-id=pictures-output]')

  it "setupWidgetIn is assinging the apiKey to a global variable", ->
    setFixtures(sandbox())
    Pictures.Controller.setupWidgetIn('#sandbox', "123456")
    expect(Pictures.API.key).toEqual("123456")

  it "setupWidgetIn binds the controller to process searches", ->
    spyOn(Pictures.Controller, 'bind')
    Pictures.Controller.setupWidgetIn('#sandbox')
    expect(Pictures.Controller.bind).toHaveBeenCalled()
