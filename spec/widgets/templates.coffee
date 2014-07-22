describe "Pictures.Widgets.Templates", ->
  it "generateClosingButton returns a closing button", ->
    button = Pictures.Widgets.Templates.generateClosingButton('pictures')
    expect(button).toBeMatchedBy('[data-name=pictures].widget-close')
