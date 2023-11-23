import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class HttpService {
  final String baseUrl = 'https://yourapi.com/api/';
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    // Add other headers here
  };

  // GET
  Future<dynamic> get(String url) async {
    try {
      final response = await http.get(Uri.parse(baseUrl + url), headers: _headers);
      return _processResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // POST
  Future<dynamic> post(String url, dynamic body) async {
    try {
      final response = await http.post(Uri.parse(baseUrl + url), headers: _headers, body: json.encode(body));
      return _processResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // Additional methods for PUT, DELETE, etc. can be added similarly

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 400:
        throw Exception('Bad request');
      case 401:
      case 403:
        throw Exception('Unauthorized or Forbidden');
      case 500:
      default:
        throw Exception('Error occurred while communicating with server with status code: ${response.statusCode}');
    }
  }
}
