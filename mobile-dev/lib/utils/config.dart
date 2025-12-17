class Config {
  // Set this via --dart-define=API_BASE_URL=https://your-backend.example/
  static String get apiBaseUrl => const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:7071');
}
