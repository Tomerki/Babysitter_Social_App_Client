import 'dart:convert';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:dart_openai/dart_openai.dart';
import 'package:http/http.dart' as http;

// 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
class ServerManager {
  static final ServerManager _instance = ServerManager._internal();

  factory ServerManager() {
    return _instance;
  }

  ServerManager._internal();


  static const String _baseUrl = 'http://172.18.71.133:8080';
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

  Future<http.Response> getRequestwithManyParams(
    String path,
    String collectionName,
    Map<String, String> queryParams,
  ) async {
    final url =
        Uri.parse('$_baseUrl/$path').replace(queryParameters: queryParams);
    print(url);
    return await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json',
      'Collection-Name': collectionName,
    });
  }

  //   Future<http.Response> getRequestInnerCollection(
  //   String path,
  //   String collectionName,
  // ) async {
  //   final url = '$_baseUrl/$path';
  //   print(url);
  //   return await http.get(Uri.parse(url), headers: <String, String>{
  //     'Content-Type': 'application/json',
  //     'Collection-Name': collectionName,
  //   });
  // }

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
      print('Error occurred during PUT request: $e');
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
    print(url);
    return await http.put(url, headers: <String, String>{
      'Content-Type': 'application/json',
      'Collection-Name': collectionName,
    });
  }

  // Future<String?> generateGPT(String prompt) async {
  //   final apiKey = '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';
  //   var url = Uri.https("api.openai.com", "v1/completions");
  //   final response = await http.post(
  //     url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       "Authorization": "Bearer $apiKey"
  //     },
  //     body: json.encode({
  //       "model": "text-davinci-003",
  //       "prompt": "Say this is a test",
  //     }),
  //   );
  //   Map<String, dynamic> newresponse = jsonDecode(response.body);
  //   print(newresponse);
  //   return newresponse['choices'][0]['text'];
  // }

// Future<void> main() async {
//   // Set the OpenAI API key from the .env file.
//   OpenAI.apiKey =  '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';

//   // Start using!
//   final completion = await OpenAI.instance.completion.create(
//     model: "text-davinci-003",
//     prompt: "Dart is",
//   );

//   // Printing the output to the console
//   print(completion.choices[0].text);

// }
}
