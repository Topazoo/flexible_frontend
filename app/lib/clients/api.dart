/*
    Author: Peter Swanson
    Description: API mixin class that allows other classes to send/receive HTTP requests
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


  Future<Map> GET(String url, [Map<String, String> params]) async {
    /*
      Description: 
        Send an asynchronous GET request to the passed url and get a future in return
      
      Parameters:
        @url - The URL to receive the data from
        @params - Optional. The query string parameters to send with the request

      Returns:
        Future<dynamic> - Resolves to a Map containing the JSON data of the request.
    */

    try {
      http.Response response = await http.get(
        url + _format_query_string(params == null ? {} : params), 
        headers: Map<String, String>.from({
            'Content-Type': 'application/json',
          })
      ); //TODO - Dynamic headers?
      
      if (response != null && response.statusCode == 200)
        return new Map.from(jsonDecode(response.body));
      
      throw new FormatException("GET Request failed with status: ${response.statusCode}.");
    }
    catch (e) {         
      print(e); return null;
    }
  }
}