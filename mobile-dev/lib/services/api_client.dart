import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/config.dart';

class ApiClient {
  final String baseUrl;
  final http.Client _client;

  ApiClient({String? baseUrl, http.Client? client})
      : baseUrl = baseUrl ?? Config.apiBaseUrl,
        _client = client ?? http.Client();

  Future<http.Response> post(String path, Map<String, dynamic> body, {Map<String, String>? headers}) {
    final url = Uri.parse('$baseUrl$path');
    final mergedHeaders = <String, String>{'Content-Type': 'application/json'};
    if (headers != null) mergedHeaders.addAll(headers);
    return _client.post(url, headers: mergedHeaders, body: json.encode(body));
  }

  Future<void> close() async => _client.close();
}
