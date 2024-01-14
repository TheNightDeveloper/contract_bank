import 'package:json_annotation/json_annotation.dart';
import 'package:contracts_bank/features/auth/domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  final String? first_name;
  final String? last_name;
  final String phone_number;
  final String? access_token;

  UserModel(
      {required this.phone_number,
      this.last_name,
      this.access_token,
      this.first_name})
      : super(
            phone_number: phone_number,
            last_name: last_name,
            first_name: first_name,
            access_token: access_token);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
