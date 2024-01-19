class ServerException implements Exception {}

class DataBaseException implements Exception {}

class WrongPasswordException implements Exception {}

class UserExistException implements Exception {}

class AuthException implements Exception {
  final String? msg;
  AuthException({this.msg});
}

class OtpException implements Exception {
  final String? msg;
  OtpException({this.msg});
}
