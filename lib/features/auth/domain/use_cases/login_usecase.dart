import 'package:dartz/dartz.dart';
import 'package:contracts_bank/core/params/auth_params.dart';
import 'package:contracts_bank/features/auth/domain/entities/user_entity.dart';
import 'package:contracts_bank/features/auth/domain/repositories/auth_repository.dart';
import 'package:contracts_bank/features/auth/domain/use_cases/auth_usecase.dart';

import '../../../../core/errors/failure.dart';

class LoginUsecase
    implements UseCase<Either<Failure, UserEntity>, LoginParams> {
  final AuthRepository authRepository;

  LoginUsecase(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    return await authRepository.login(params);
  }
}
