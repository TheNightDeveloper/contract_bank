abstract class Failure {
  final String errorMessage;
  const Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required String errorMessage})
      : super(errorMessage: errorMessage);
}

class OtpFailure extends Failure {
  OtpFailure({required String errorMessage})
      : super(errorMessage: errorMessage);
}

class SerachFailure extends Failure {
  SerachFailure({required String errorMessage})
      : super(errorMessage: errorMessage);
}
class AuthFailure extends Failure {
  AuthFailure({required String errorMessage})
      : super(errorMessage: errorMessage);
}

class BookmarkFailure extends Failure {
  BookmarkFailure({required String errorMessage})
      : super(errorMessage: errorMessage);
}
