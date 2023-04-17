import 'package:http/http.dart' as http;

class ServerManager {
  static final ServerManager _instance = ServerManager._internal();

  factory ServerManager() {
    return _instance;
  }

  ServerManager._internal();

  static const String _baseUrl = 'http://192.168.0.129:8080';

  Future<http.Response> getRequest(String path) async {
    final url = '$_baseUrl/$path';
    return await http.get(Uri.parse(url));
  }

  Future<http.Response> postRequest(String path, {required String body}) async {
    final url = '$_baseUrl/$path';
    return await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: body,
    );
  }
}
