import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String phone_number;
  final String? first_name;
  final String? last_name;
  final String? access_token;
  UserEntity(
      {required this.phone_number,
      this.first_name,
      this.last_name,
      this.access_token});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [phone_number, first_name, last_name, access_token];
}
