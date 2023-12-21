import 'package:dartz/dartz.dart';
import 'package:contract_bank/core/errors/failure.dart';
import 'package:contract_bank/core/params/user_params.dart';
import 'package:contract_bank/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(LoginParams loginParams);
  Future<Either<Failure, bool>> register(RegisterParams registerParams);
  Future<Either<Failure, UserEntity>> verify(List list);
  Future<Either<Failure, bool>> sendCode(Map<String, dynamic> data);
  Future<Either<Failure, bool>> newPassword(Map<String, dynamic> newData);
}
