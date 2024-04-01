import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:weather/src/data/models/http/api_error.dart';

class HttpService {

  Future<Map<String, String>> getHeaders() async {
    var headers = {'Content-Type': 'application/json'};

    // if (await Preferences.isUserLoggedIn()) {
    //   headers['Authorization'] = 'Bearer ${await Preferences.getToken()}';
    // }

    return headers;
  }

  Future httpGet(String url, [Map<String, dynamic>? params]) async {
    final paramValues = [];
    if (params != null) {
      for (var key in params.keys) {
        if (params[key] != null) {
          paramValues.add('$key=${params[key]}');
        }
      }
    }

    return _parseResponse(await http.get(
        Uri.parse('$url${paramValues.isNotEmpty ? '?${paramValues.join('&')}' : ''}'),
        headers: await getHeaders()));
  }

  Future httpPost(String url, dynamic data) async {
    Uri uri = Uri.parse(url);
    return _parseResponse(await http.post(uri,
        headers: await getHeaders(), body: json.encode(data)));
  }

  Future httpPut(String url, dynamic data) async {
    return _parseResponse(
      await http.put(
        Uri.parse(url),
        headers: await getHeaders(), body: json.encode(data)
      )
    );
  }

  Future httpDelete(String url) async {
    return _parseResponse(await http.delete(
        Uri.parse(url),
        headers: await getHeaders()));
  }

  _parseResponse(http.Response response) {
    final data = json.decode(response.body);

    if (response.statusCode < 200 || response.statusCode >= 400) {
      throw ApiError.fromJson(data);
    }

    return data;
  }
}
