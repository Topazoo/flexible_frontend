// Demo class to quickly render API data as a scrollable list

import 'package:app/widgets/base/api_list.dart';
import 'package:flutter/material.dart';

class DemoList extends API_List_Widget {
  final String url;
  final String path;

  DemoList({Key key, this.url, this.path}) : super(key: key);

  Widget titleWidget(dynamic data, int index) => Text("${data[index]['item']['name']}");  
  Widget subTitleWidget(dynamic data, int index) => Text("Price: ${data[index]['item']['current']['price']}gp | Change: ${data[index]['item']['today']['price']}gp");                       
}