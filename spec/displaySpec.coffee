describe "Pictures.Display", ->
  it "generateLogo returns the pictures image tag", ->
    imageHtml = Pictures.Display.generateLogo({dataId: "pictures-logo", class: "some-class"})
    expect(imageHtml).toBeMatchedBy('[data-id=pictures-logo]')
    expect(imageHtml).toBeMatchedBy('.some-class')
