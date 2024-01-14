import 'package:dartz/dartz.dart';
import 'package:contracts_bank/core/errors/exceptions.dart';
import 'package:contracts_bank/core/errors/failure.dart';

import 'package:contracts_bank/core/params/auth_params.dart';
import 'package:contracts_bank/features/auth/data/data_sources/auth_remote_data.dart';
import 'package:contracts_bank/features/auth/data/models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteData remoteData;
  // final NetworkInfo networkInfo;
  AuthRepositoryImpl({required this.remoteData});

  @override
  Future<Either<Failure, UserModel>> login(LoginParams loginParams) async {
    try {
      final loginUser = await remoteData.login(loginParams);
      return Right(loginUser);
    } on AuthException {
      return Left(
          AuthFailure(errorMessage: 'نام کاربری یا رمز عبور اشتباه است'));
    }
  }

  @override
  Future<Either<Failure, bool>> register(RegisterParams registerParams) async {
    try {
      final registerUser = await remoteData.register(registerParams);
      print(registerUser);
      return Right(registerUser);
    } on AuthException {
      return Left(AuthFailure(errorMessage: 'error while register'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> verify(List list) async {
    try {
      final resault = await remoteData.verify(list);
      return Right(resault);
    } on AuthException {
      return Left(AuthFailure(errorMessage: 'error while verifying'));
    }
  }

  @override
  Future<Either<Failure, bool>> newPassword(
      Map<String, dynamic> newData) async {
    try {
      final resault = await remoteData.newPassword(newData);
      return Right(resault);
    } on OtpException {
      return Left(OtpFailure(errorMessage: ' set new password fail'));
    }
  }

  @override
  Future<Either<Failure, bool>> sendCode(Map<String, dynamic> data) async {
    try {
      final resault = await remoteData.sendCode(data);
      return Right(resault);
    } on OtpException {
      return Left(OtpFailure(errorMessage: ' otp sending fail'));
    }
  }
}
