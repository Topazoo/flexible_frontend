/*
    Author: Peter Swanson
    Description: API widget mixin class that allows easy instantiation of an subclass list widget
                 that relies on API call data
*/

import 'api_widget.dart';
import 'package:flutter/material.dart';

class API_List_Widget extends API_Widget {
  // Base widget for any widget that relies on an API call to supply data to a scrollable list

  API_List_Widget({Key key, this.url, this.path}) : super(key: key);
  /*
    Params:
      - url [String]  | The url to use for the  GET request
      - path [String] | The path to the data to supply the widget with. E.g. ('data' if the JSON is {'data': 'value you want'})

    Notes:
      - Should override the widgets below to create more unique subclasses that handle
        styling, formatting, etc. This class allows the most basic rendering of API call data as a list
  */

  final String url;
  final String path;

  Widget titleWidget(dynamic data, int index) => Text(data[index].toString());    // List tile title widget    [Can be overidden]
  Widget subTitleWidget(dynamic data, int index) => null;                         // List tile subtitle widget [Can be overidden]

  @override
  Widget displayWidget(BuildContext context, dynamic data) => new Expanded(
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
            title: titleWidget(data, index),
            subtitle: subTitleWidget(data, index),
        );
      }
    )
  );
}
