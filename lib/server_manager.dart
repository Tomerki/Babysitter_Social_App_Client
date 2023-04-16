import 'package:http/http.dart' as http;

class ServerManager {
  static final ServerManager _instance = ServerManager._internal();

  factory ServerManager() {
    return _instance;
  }

  ServerManager._internal();

  static const String _baseUrl = 'http://192.168.1.45:8080';

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





// Future<void> postData(String body) async {
  //   final response = await http.post(
  //     Uri.parse('http://192.168.1.45:8080'),
      // headers: <String, String>{
      //   'Content-Type': 'application/json',
      // },
  //     body: body,
  //   );
  //   if (response.statusCode == 200) {
  //     // Job added successfully
  //     // Parse the response to get the ID of the new job
  //     Map<String, dynamic> data = jsonDecode(response.body);
  //     String jobId = data['id'];
  //     print('the jobid = $jobId');
  //   } else {
  //     // Job not added
  //     throw Exception('Failed to add job');
  //   }
  // }