describe "Pictures.Display", ->
  it "generateLogo returns the pictures image tag", ->
    imageHtml = Pictures.Display.generateLogo({dataId: "pictures-logo"})
    expect(imageHtml).toBeMatchedBy('[data-id=pictures-logo]')
