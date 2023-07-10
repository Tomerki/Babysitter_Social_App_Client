import 'dart:convert';
import 'package:http/http.dart' as http;

class ServerManager {
  static final ServerManager _instance = ServerManager._internal();

  factory ServerManager() {
    return _instance;
  }

  ServerManager._internal();

  static const String _baseUrl = 'http://192.168.0.129:8080';
  Future<http.Response> getRequest(
    String path,
    String collectionName,
  ) async {
    final url = '$_baseUrl/$path';
    return await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
      'Collection-Name': collectionName,
    });
  }

  Future<http.Response> getRequestwithManyParams(
    String path,
    String collectionName,
    Map<String, String> queryParams,
  ) async {
    final url =
        Uri.parse('$_baseUrl/$path').replace(queryParameters: queryParams);
    return await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json',
      'Collection-Name': collectionName,
    });
  }

  Future<http.Response> postRequest(String path, String collectionName,
      {required String body}) async {
    final url = '$_baseUrl/$path';
    return await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Collection-Name': collectionName,
      },
      body: body,
    );
  }

  Future<http.Response> putRequest(String path, String collectionName,
      {required String body}) async {
    final url = '$_baseUrl/$path';
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Collection-Name': collectionName,
        },
        body: body,
      );
      return response;
    } catch (e) {
      // Handle any exceptions that may be thrown during the request
      rethrow;
    }
  }

  Future<http.Response> deleteRequest(
    String path,
    String collectionName,
  ) async {
    final url = '$_baseUrl/$path';
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Collection-Name': collectionName,
        },
      );
      return response;
    } catch (e) {
      // Handle any exceptions that may be thrown during the request
      rethrow;
    }
  }

  Future<http.Response> updateElementFromArray(
    String path,
    String collectionName,
    Map<String, String> queryParams,
  ) async {
    final url =
        Uri.parse('$_baseUrl/$path').replace(queryParameters: queryParams);

    return await http.put(url, headers: <String, String>{
      'Content-Type': 'application/json',
      'Collection-Name': collectionName,
    });
  }

  static Future<bool> checkLanguage(String paragraph) async {
    final response = await http.post(Uri.parse('$_baseUrl/check-language'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'paragraph': paragraph}));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['has_profanity'];
    } else {
      throw Exception('Failed to check language');
    }
  }
}
