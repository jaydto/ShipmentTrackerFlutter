// API-related action types here
class ApiRequestAction {
  final String endpoint;
  final String method;
  final dynamic data;
  final bool useJwt;

  ApiRequestAction({
    required this.endpoint,
    required this.method,
    this.data,
    this.useJwt = false,
  });
}

class ApiSuccessAction {
  final dynamic response;

  ApiSuccessAction(this.response);
}

class ApiFailureAction {
  final String error;

  ApiFailureAction(this.error);
}

// Define other action types for your app here
