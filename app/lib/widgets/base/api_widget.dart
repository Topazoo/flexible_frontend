/*
    Author: Peter Swanson
    Description: API widget mixin class that allows easy instantiation of an subclass widget
                 that relies on API call data
*/

import 'dart:convert';

import 'package:app/clients/api.dart';
import 'package:flutter/material.dart';

class API_Widget extends StatefulWidget {
  // Base widget for any widget that relies on an API call to supply data

  API_Widget({Key key, this.url, this.path}) : super(key: key);
  /*
    Params:
      - url [String]  | The url to use for the  GET request
      - path [String] | The path to the data to supply the widget with. E.g. ('data' if the JSON is {'data': 'value you want'})

    Notes:
      - Should override the widgets below to create more unique subclasses that handle
        styling, formatting, etc. This class allows the most basic rendering of API call data.
  */

  final String url;
  final String path;

  Widget placeholderWidget() => CircularProgressIndicator();                           // Placeholder widget [Can be overidden]

  Widget displayWidget(BuildContext context, dynamic data) => Text(data.toString());   // Display widget [Can be overidden]

  Widget errorWidget(String error) => Row(children:[
      Icon(Icons.warning, color: Colors.red),
      Text(error, style: TextStyle(color: Colors.red),)], 
    mainAxisAlignment: MainAxisAlignment.center);                                     // Error widget [Can be overidden]

  @override
  _APIWidgetState createState() => _APIWidgetState();
}

class _APIWidgetState extends State<API_Widget> with API {

  @override
  Widget build(BuildContext context) => FutureBuilder(
    // Internal build logic, change displayed widget based on state

    future: GET(widget.url),                            // Attempt GET request
    builder: (context, snapshot) {
      if (snapshot.hasData && snapshot.data != null)    // State 1 - Success [Render display widget with data]
        return widget.displayWidget(context, widget.path != null ? snapshot.data[widget.path] : snapshot.data); // TODO - Error handling
      else if (snapshot.hasError)                       // State 2 - Error   [Render error widget]
        return widget.errorWidget("${snapshot.error}");
      return widget.placeholderWidget();                // State 3 - Loading [Render placeholder widget]
    },
  );
}
