import 'package:dartz/dartz.dart';
import 'package:contracts_bank/core/errors/failure.dart';
import 'package:contracts_bank/core/params/auth_params.dart';
import 'package:contracts_bank/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(LoginParams loginParams);
  Future<Either<Failure, bool>> register(RegisterParams registerParams);
  Future<Either<Failure, UserEntity>> verify(List list);
  Future<Either<Failure, bool>> sendCode(Map<String, dynamic> data);
  Future<Either<Failure, bool>> newPassword(Map<String, dynamic> newData);
}
