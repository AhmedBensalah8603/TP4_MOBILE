import 'dart:convert';
import '../services/api_client.dart';
import '../services/auth_service.dart';
import '../models/avatar_response.dart';

class AvatarService {
  final ApiClient _apiClient;
  final AuthService? _authService;

  AvatarService({required ApiClient apiClient, AuthService? authService})
      : _apiClient = apiClient,
        _authService = authService;

  /// Sends a message to the backend avatar endpoint and returns parsed response
  Future<AvatarResponse> sendMessage(String text) async {
    final headers = <String, String>{};
    final token = await _authService?.getIdToken();
    if (token != null) headers['Authorization'] = 'Bearer $token';

    final res = await _apiClient.post('/avatar/message', {'text': text}, headers: headers);
    if (res.statusCode >= 200 && res.statusCode < 300) {
      final body = json.decode(res.body) as Map<String, dynamic>;
      return AvatarResponse.fromJson(body);
    }
    throw Exception('Avatar API error: ${res.statusCode} ${res.body}');
  }
}
