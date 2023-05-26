import 'package:http/http.dart' as http;

class ServerManager {
  static final ServerManager _instance = ServerManager._internal();

  factory ServerManager() {
    return _instance;
  }

  ServerManager._internal();

  static const String _baseUrl = 'http://192.168.1.43:8080';

  Future<http.Response> getRequest(
    String path,
    String collectionName,
  ) async {
    final url = '$_baseUrl/$path';
    print(url);
    return await http.get(Uri.parse(url), headers: <String, String>{
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
      print('Error occurred during PUT request: $e');
      rethrow;
    }
  }
}
