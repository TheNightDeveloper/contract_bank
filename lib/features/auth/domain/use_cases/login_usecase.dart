import 'package:dartz/dartz.dart';
import 'package:contract_bank/core/params/user_params.dart';
import 'package:contract_bank/features/auth/domain/entities/user_entity.dart';
import 'package:contract_bank/features/auth/domain/repositories/auth_repository.dart';
import 'package:contract_bank/features/auth/domain/use_cases/auth_usecase.dart';

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
