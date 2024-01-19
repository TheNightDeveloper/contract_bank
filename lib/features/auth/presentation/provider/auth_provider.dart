import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:contracts_bank/core/params/auth_params.dart';
import 'package:contracts_bank/core/utils/const.dart';
import 'package:contracts_bank/features/auth/domain/entities/user_entity.dart';
import 'package:contracts_bank/features/auth/domain/use_cases/login_usecase.dart';
import 'package:contracts_bank/features/auth/domain/use_cases/newpassword_usecase.dart';
import 'package:contracts_bank/features/auth/domain/use_cases/otp_usecase.dart';
import 'package:contracts_bank/features/auth/domain/use_cases/register_usecase.dart';
import 'package:contracts_bank/features/auth/domain/use_cases/verify_usecase.dart';

import '../../../../core/errors/failure.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final VerifyUsecase verifyUsecase;
  final OtpUsecase otpUsecase;
  final NewpasswordUsecase newpasswordUsecase;
  UserEntity? user;
  Failure? failure;
  bool isLoggedIn = false;
  bool isLoading = false;

  AuthProvider({
    required this.otpUsecase,
    required this.newpasswordUsecase,
    required this.loginUsecase,
    required this.registerUsecase,
    required this.verifyUsecase,
  });

  void logOut() {
    user = null;
    isLoggedIn = false;
    notifyListeners();
  }

  void loading(bool load) {
    isLoading = load;
    notifyListeners();
  }

  Future<bool> eitherFailureOrLogin(
      LoginParams loginParams, BuildContext context) async {
    loading(true);
    final failureOrUserEntity = await loginUsecase.call(loginParams);
    return failureOrUserEntity.fold((fail) {
      failure = fail;
      Fluttertoast.showToast(msg: fail.errorMessage);
      loading(false);
      notifyListeners();

      return false;
    }, (userr) {
      user = userr;
      prefs.setString(storageDeviceAccessToken, user!.access_token!);
      prefs.setString(storageDevicePhoneNumber, loginParams.phoneNumber);
      prefs.setString(storageDevicePassword, loginParams.password);
      prefs.setBool(storageDeviceIsLoggedIn, true);
      isLoggedIn = true;
      loading(false);
      // Fluttertoast.showToast(msg: 'موفق');
      notifyListeners();
      return true;
    });
  }

  Future<bool> eitherFailureOrRegister(RegisterParams registerParams) async {
    loading(true);
    final failureOrBool = await registerUsecase.call(registerParams);
    return failureOrBool.fold((fail) {
      Fluttertoast.showToast(msg: fail.errorMessage);
      failure = fail;
      notifyListeners();
      loading(false);
      return false;
    }, (bool) {
      loading(false);
      if (bool) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<void> eitherOrVerify(List list) async {
    loading(true);
    final failureOrUserEntity = await verifyUsecase.call(list);
    failureOrUserEntity.fold((fail) {
      Fluttertoast.showToast(msg: fail.errorMessage);
      loading(false);
    }, (userr) {
      user = userr;
      prefs.setString(storageDeviceAccessToken, user!.access_token!);
      prefs.setString(storageDevicePhoneNumber, list[1]);
      prefs.setString(storageDevicePassword, list[2]);
      prefs.setBool(storageDeviceIsLoggedIn, true);
      isLoggedIn = true;
      loading(false);
      Fluttertoast.showToast(msg: 'ثبت نام با موفقیت انجام شد');
      notifyListeners();
    });
  }

  Future<bool> eitherOrOtp(
      {required String phoneNumber, required String otpType}) async {
    Map<String, dynamic> data = {
      "phone_number": phoneNumber,
      "otp_type": otpType
    };
    final failureOrOtp = await otpUsecase.call(data);
    return failureOrOtp.fold((l) {
      Fluttertoast.showToast(msg: l.errorMessage);
      return false;
    }, (send) {
      Fluttertoast.showToast(msg: 'کد ارسال شد');
      return true;
    });
  }

  Future<bool> eitherOrNewpassword(
      {required String phoneNumber,
      required String code,
      required String newPassword}) async {
    Map<String, dynamic> data = {
      "phone_number": phoneNumber,
      "code": code,
      "password": newPassword
    };
    final failureOrNewpassword = await newpasswordUsecase.call(data);
    return failureOrNewpassword.fold((fail) {
      Fluttertoast.showToast(msg: 'کد وارد شده اشتباه است');
      return false;
    }, (bool) {
      if (bool) {
        Fluttertoast.showToast(msg: 'کلمه عبور با موفقیت تغییر کرد');
        return true;
      } else {
        return false;
      }
    });
  }
}
