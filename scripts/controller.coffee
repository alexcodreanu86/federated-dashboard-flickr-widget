namespace('Pictures')

class Pictures.Controller
  @setupWidgetIn: (settings) ->
    new Pictures.Widgets.Controller(settings).initialize()
