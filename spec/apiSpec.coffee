describe "Pictures.API", ->
  it "search passes the results to the callback", ->
    callbackSpy = jasmine.createSpy('callbackSpy')
    result = Pictures.API.search("string", callbackSpy)
    expect(callbackSpy).toHaveBeenCalledWith([{url_n: "/spec/mockImages/url1.jpeg"}, {url_n: "/spec/mockImages/url2.jpeg"}, {url_n: "/spec/mockImages/url3.jpeg"}, {url_n: "/spec/mockImages/url4.jpeg"}, {url_n: "/spec/mockImages/url5.jpeg"}, {url_n: "/spec/mockImages/url6.jpeg"}])
