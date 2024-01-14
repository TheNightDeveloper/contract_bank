class LoginParams {
  final String phoneNumber;
  final String password;

  LoginParams(this.phoneNumber, this.password);
}

class RegisterParams {
  final String firstname;
  final String lastname;
  final String phoneNumber;
  final String password;

  RegisterParams({  required this.firstname, required this.lastname, required this.password, required this.phoneNumber}
    );
}
