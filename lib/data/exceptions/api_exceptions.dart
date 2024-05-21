// ignore_for_file: prefer_typing_uninitialized_variables

class AppExceptions implements Exception {
  final message;
  final statusCode;

  AppExceptions([this.message,this.statusCode]);

  @override
  String toString() {
    return '$message';
  }
}

class InternetExceptions extends AppExceptions {
  InternetExceptions([String? super.message, String? super.statusCode]);
}

class RequestExceptions extends AppExceptions {
  RequestExceptions([String? super.message, String? super.statusCode]);
}

class ServerExceptions extends AppExceptions {
  ServerExceptions([String? super.message, String? super.statusCode]);
}

class AuthoricationExceptions extends AppExceptions {
  AuthoricationExceptions([String? super.message, String? super.statusCode]);
}

class TimeOutExceptions extends AppExceptions {
  TimeOutExceptions([String? super.message, String? super.statusCode]);
}

class FetchDataExceptions extends AppExceptions {
  FetchDataExceptions([String? super.message, String? super.statusCode]);
}

class InvalidUrlExceptions extends AppExceptions {
  InvalidUrlExceptions([String? super.message, String? super.statusCode]);
}
