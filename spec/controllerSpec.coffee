describe "Pictures.Controller", ->
  it "setupWidgetIn is setting up a widget instance in the desired element", ->
    setFixtures sandbox()
    Pictures.Controller.setupWidgetIn({container: '#sandbox', key: "123456"})
    html = $('#sandbox')

    expect(html).toContainElement('[data-name=widget-close]')
    expect(html).toContainElement('[data-name=widget-form]')
    expect(html).toContainElement('[data-name=widget-output]')
