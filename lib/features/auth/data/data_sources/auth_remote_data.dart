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
    // try {
    var userModel;
    Map<String, String> loginData = {
      "phone_number": loginParams.phoneNumber,
      "password": loginParams.password
    };
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await dio.fetch(RequestOptions(
        path: '${BASE_URL}accounts/login',
        data: jsonEncode(loginData),
        method: 'POST',
        validateStatus: (status) {
          return status! >= 200 && status <= 400;
        }));
    if (response.statusCode == 200) {
      userModel = UserModel.fromJson(response.data! as Map<String, dynamic>);
    } else {
      print('error:${response.data}');
      throw AuthException(msg: response.data['non_field_errors'][0]);
    }
    return userModel;
    // } catch (e) {
    //   print('login error;$e');
    //   throw AuthException();
    // }
  }

  @override
  Future<bool> register(RegisterParams registerParams) async {
    // try {
    var registered;
    Map<String, String> registerData = {
      "first_name": registerParams.firstname,
      "last_name": registerParams.lastname,
      "phone_number": registerParams.phoneNumber,
      "password": registerParams.password
    };
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await dio.fetch(RequestOptions(
        path: '${BASE_URL}accounts/register',
        method: 'POST',
        data: jsonEncode(registerData),
        validateStatus: (status) {
          return status! >= 200 && status <= 400;
        }));
    if (response.statusCode == 200) {
      registered = true;
    } else {
      print('error:${response.data}');
      // registered = false;
      throw AuthException(msg: response.data['non_field_errors'][0]);
    }
    return registered;
    // } catch (e) {
    //   print('register error: $e');
    //   throw AuthException();
    // }
  }

  @override
  Future<UserModel> verify(List list) async {
    var user;
    var data = jsonEncode({"code": list[0], "phone_number": list[1]});
    var response = await dio.fetch(RequestOptions(
        path: '${BASE_URL}accounts/verify',
        method: 'POST',
        data: data,
        validateStatus: (status) {
          return status! >= 200 && status <= 400;
        }));

    if (response.statusCode == 200) {
      user = UserModel.fromJson(response.data!);
    } else {
      throw AuthException(msg: response.data["code"][0]);
    }
    return user;
  }

  @override
  Future<bool> sendCode(Map<String, dynamic> dataa) async {
    // try {
    var data = jsonEncode(dataa);
    var response = await dio.fetch(RequestOptions(
        path: '${BASE_URL}accounts/send_code',
        data: data,
        method: 'POST',
        validateStatus: (status) {
          return status! >= 200 && status <= 400;
        }));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw OtpException(msg: response.data['non_field_errors'][0]);
    }
    // } catch (e) {
    //   print('otp erroe');
    //   throw OtpException();
    // }
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
