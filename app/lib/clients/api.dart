/*
    Author: Peter Swanson
    Description: API widget base class that allows subclasses to use data from HTTP requests
*/

import 'dart:convert';
import 'package:http/http.dart' as http;

mixin API {
  String _format_query_string(Map<String, String> params) =>
  (params.length == 0) ? '' :
  '?' + params.entries.map((entry) => (entry.key != 'Cookie' && entry.key != 'Content-Type') ? entry.key + '='  + entry.value : '').join('&');

  /*
    Description: 
      Take a map of GET parameters and format them as a string, ignoring some default parameters
    
    Parameters:
      @params - A map of GET parameters
    Returns:
      String - The parameters in string form
  */


  Future<Map> GET(String url,{ignore_errors=false, Map<String, String> params}) async {
    /*
      Description: 
        Send an asynchronous GET request to the passed url and get a future in return
      
      Parameters:
        @url - The URL to receive the data from
        @params - Optional. The query string parameters to send with the request

      Returns:
        Future<dynamic> - Resolves to a Map containing the JSON data of the request.
    */

    String full_url = url + _format_query_string(params == null ? {} : params);

    try {
      http.Response response = await http.get(
        full_url, headers: Map<String, String>.from({
            'Content-Type': 'application/json',
          })
      ); //TODO - Dynamic headers?
      
      if (response != null && response.statusCode == 200)
        return new Map.from(jsonDecode(response.body.toString()));
      
      if (!ignore_errors)
        throw new FormatException("GET Request failed with status: ${response.statusCode}");
    }
    catch (e) {   
      if (!ignore_errors)
        throw "${e.toString()} | [$full_url]";

      print(e);
    }
  }
}