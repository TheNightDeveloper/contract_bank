import 'package:dartz/dartz.dart';
import 'package:contract_bank/features/auth/domain/entities/user_entity.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/auth_repository.dart';
import 'auth_usecase.dart';

class VerifyUsecase implements UseCase<Either<Failure, UserEntity>, List> {
  final AuthRepository authRepository;

  VerifyUsecase(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(List list) async {
    return await authRepository.verify(list);
  }
}
