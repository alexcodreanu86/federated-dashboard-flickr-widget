#Federated Dashboard flickr-widget

To install this package you can just add `flickr-widget: ">0.0.3"` to your dependencies in your bower.json file or by executing `bower install flickr-widget` in the terminal inside your project directory.

To use the widget just add the `dist/federated-dashboard-flickr-widget.js` to your html file. If you have the widget in the `bower_components` directory. You can just copy the next script tag into the `<head>` of your html file:

```html
<script src="/bower_components/markitondemand-widget/dist/federated-dashboard-markitondemand-widget.js"></script>
```

Now all you have to do is call Pictures.Controller.setupWidgetIn('.container', 'api_key_here') where .container can be any desired JQuery selector that you want to serve as the container of the widget and `your_api_key` is the api key that you got from [flickr.com](https://www.flickr.com/services/apps/create/apply/)
