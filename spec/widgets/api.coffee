describe "Pictures.Widgets.API", ->
  it "search passes the results to the callback", ->
    callbackSpy = jasmine.createSpy('callbackSpy')
    data = {key: "124", searchString: "string"}
    result = Pictures.Widgets.API.search(data, { showImages: callbackSpy })
    expect(callbackSpy).toHaveBeenCalledWith([{url_n: "/spec/mockImages/url1.jpeg"}, {url_n: "/spec/mockImages/url2.jpeg"}, {url_n: "/spec/mockImages/url3.jpeg"}, {url_n: "/spec/mockImages/url4.jpeg"}, {url_n: "/spec/mockImages/url5.jpeg"}, {url_n: "/spec/mockImages/url6.jpeg"}])
