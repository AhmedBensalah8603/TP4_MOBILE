class AvatarResponse {
  final String replyText;
  final String? ttsUrl; // URL to generated audio (optional)

  AvatarResponse({required this.replyText, this.ttsUrl});

  factory AvatarResponse.fromJson(Map<String, dynamic> json) => AvatarResponse(
        replyText: json['replyText'] ?? '',
        ttsUrl: json['ttsUrl'] as String?,
      );
}
