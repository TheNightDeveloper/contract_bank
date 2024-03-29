import 'package:dartz/dartz.dart';
import 'package:contracts_bank/core/params/auth_params.dart';
import 'package:contracts_bank/features/auth/domain/entities/user_entity.dart';
import 'package:contracts_bank/features/auth/domain/repositories/auth_repository.dart';
import 'package:contracts_bank/features/auth/domain/use_cases/auth_usecase.dart';

import '../../../../core/errors/failure.dart';

class RegisterUsecase
    implements UseCase<Either<Failure, bool>, RegisterParams> {
  final AuthRepository authRepository;

  RegisterUsecase(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(RegisterParams params) async {
    return await authRepository.register(params);
  }
}
