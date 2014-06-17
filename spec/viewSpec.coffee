inputInto = (name, value)->
  $("[name=#{name}]").val(value)

describe "Pictures.View", ->

  it "getInput returns the pictures-search field", ->
    setFixtures '<input name="pictures-search" type="text"><br>'
    inputInto('pictures-search', "123")
    expect(Pictures.View.getInput()).toEqual("123")

  it "addImages displays the images on the screen", ->
    setFixtures "<div data-id='pictures-output'></div>"
    images =  [{url_n: "/spec/mockImages/url1.jpeg"}, {url_n: "/spec/mockImages/url2.jpeg"}, {url_n: "/spec/mockImages/url3.jpeg"}, {url_n: "/spec/mockImages/url4.jpeg"}, {url_n: "/spec/mockImages/url5.jpeg"}, {url_n: "/spec/mockImages/url6.jpeg"}]
    Pictures.View.addImages(images)
    expect($('img').length).toEqual(6)

  it "appendFormTo appends the pictures form to the given container", ->
    setFixtures(sandbox())
    Pictures.View.appendFormTo('#sandbox')
    container = $('#sandbox')
    expect(container).toContainElement('[name=pictures-search]')
    expect(container).toContainElement('[data-id=pictures-button]')
    expect(container).toContainElement('[data-id=pictures-output]')