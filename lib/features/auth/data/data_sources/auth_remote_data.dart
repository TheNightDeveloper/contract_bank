import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:contracts_bank/config/routes/routes.dart';
import 'package:contracts_bank/core/errors/exceptions.dart';
import '../../../../core/params/auth_params.dart';
import '../models/user_model.dart';

abstract class AuthRemoteData {
  Future<UserModel> login(LoginParams loginParams);
  Future<bool> register(RegisterParams registerParams);
  Future<UserModel> verify(List list);
  Future<bool> sendCode(Map<String, dynamic> data);
  Future<bool> newPassword(Map<String, dynamic> newData);
}

class AuthRemoteDataImpl implements AuthRemoteData {
  final Dio dio;

  AuthRemoteDataImpl(this.dio);

  @override
  Future<UserModel> login(LoginParams loginParams) async {
    try {
      var userModel;
      Map<String, String> loginData = {
        "phone_number": loginParams.phoneNumber,
        "password": loginParams.password
      };
      Map<String, String> header = {'Content-Type': 'application/json'};
      var response = await dio.post(
        '${BASE_URL}accounts/login',
        data: jsonEncode(loginData),
      );
      if (response.statusCode == 200) {
        userModel = UserModel.fromJson(response.data! as Map<String, dynamic>);
      } else {
        print('error:${response.statusMessage}');
        throw AuthException();
      }
      return userModel;
    } catch (e) {
      print('login error;$e');
      throw AuthException();
    }
  }

  @override
  Future<bool> register(RegisterParams registerParams) async {
    try {
      var registered;
      Map<String, String> registerData = {
        "first_name": registerParams.firstname,
        "last_name": registerParams.lastname,
        "phone_number": registerParams.phoneNumber,
        "password": registerParams.password
      };
      Map<String, String> header = {'Content-Type': 'application/json'};
      var response = await dio.post(
        '${BASE_URL}accounts/register',
        data: jsonEncode(registerData),
      );
      if (response.statusCode == 200) {
        registered = true;
      } else if (response.statusCode == 400) {
        print('error:${response.data}');
        registered = false;
        throw AuthException();
      }
      return registered;
    } catch (e) {
      print('register error: $e');
      throw AuthException();
    }
  }

  @override
  Future<UserModel> verify(List list) async {
    try {
      var user;
      var data = jsonEncode({"code": list[0], "phone_number": list[1]});
      print(data);
      final response = await dio.post('${BASE_URL}accounts/verify', data: data);
      if (response.statusCode == 200) {
        user = UserModel.fromJson(response.data!);
      } else {
        print('error:${response.statusMessage}');
        throw AuthException();
      }
      return user;
    } catch (e) {
      print('verify error:$e');
      throw AuthException();
    }
  }

  @override
  Future<bool> sendCode(Map<String, dynamic> dataa) async {
    try {
      var data = jsonEncode(dataa);
      var response =
          await dio.post('${BASE_URL}accounts/send_code', data: data);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw OtpException();
      }
    } catch (e) {
      print('otp erroe');
      throw OtpException();
    }
  }

  @override
  Future<bool> newPassword(Map<String, dynamic> newData) async {
    try {
      var data = jsonEncode(newData);
      var response =
          await dio.post('${BASE_URL}accounts/new_password', data: data);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw OtpException();
      }
    } catch (e) {
      print('new password erroe:$e');
      throw OtpException();
    }
  }
}
