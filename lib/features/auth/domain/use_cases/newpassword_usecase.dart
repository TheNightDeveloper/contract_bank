import 'package:dartz/dartz.dart';
import 'package:contract_bank/core/errors/failure.dart';
import 'package:contract_bank/features/auth/domain/repositories/auth_repository.dart';
import 'package:contract_bank/features/auth/domain/use_cases/auth_usecase.dart';

class NewpasswordUsecase
    implements UseCase<Either<Failure, bool>, Map<String, dynamic>> {
  final AuthRepository repository;
  NewpasswordUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(Map<String, dynamic> params) async {
    return await repository.newPassword(params);
  }
}
