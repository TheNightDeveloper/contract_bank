// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      phone_number: json['phone_number'] as String,
      last_name: json['last_name'] as String?,
      access_token: json['access_token'] as String?,
      first_name: json['first_name'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'phone_number': instance.phone_number,
      'access_token': instance.access_token,
    };
