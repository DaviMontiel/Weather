class ApiError {
  int statusCode;
  String? error = '';
  String? message = '';

  ApiError.fromJson(Map<String, dynamic> json)
      : statusCode = json['statusCode'],
        error = json['error'],
        message = json.containsKey('message') ? json['message'] : '';
}
