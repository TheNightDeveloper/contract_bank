import 'package:dartz/dartz.dart';
import 'package:contract_bank/core/errors/failure.dart';
import 'package:contract_bank/features/article/domain/repositories/article_repository.dart';
import 'package:contract_bank/features/article/domain/use_cases/article_usecase.dart';

class DeleteBookmarkUsecase
    implements ArticleUsecase<Either<Failure, String>, String> {
  final ArticleRepository repository;
  DeleteBookmarkUsecase(this.repository);

  @override
  Future<Either<Failure, String>> call({String? params}) async {
    return await repository.deleteBookmark(params!);
  }
}
