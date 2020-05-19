/*
    Author: Peter Swanson
    Description: API widget mixin class that allows easy instantiation of an existing widget
                 that relies on API call data
*/

import 'package:app/clients/api.dart';
import 'package:flutter/material.dart';

class API_Widget extends StatefulWidget {
  // Base widget for any widget that relies on an API call to supply data

  API_Widget({Key key, this.url}) : super(key: key);
  /*
    Params:
      - url [String] | The url to use for the  GET request
  */

  final String url;

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
        return displayWidget(snapshot.data['data']);
      else if (snapshot.hasError)                       // State 2 - Error   [Render error widget]
        return errorWidget("${snapshot.error}");
      return placeholderWidget();                       // State 3 - Loading [Render placeholder widget]
    },
  );


  Widget placeholderWidget() => CircularProgressIndicator();                  // Placeholder widget [Can be overidden]

  Widget displayWidget(Map<String, dynamic> data) => Text(data.toString());   // Display widget [Can be overidden]

  Widget errorWidget(String error) => Text(error);                            // Error widget [Can be overidden]
}
