import 'package:dartz/dartz.dart';
import 'package:contracts_bank/core/errors/failure.dart';
import 'package:contracts_bank/features/article/domain/entities/article_entity.dart';
import 'package:contracts_bank/features/article/domain/repositories/article_repository.dart';
import 'package:contracts_bank/features/article/domain/use_cases/article_usecase.dart';

class SearchUsecase
    implements ArticleUsecase<Either<Failure, List<ArticleEntity>>, String> {
  final ArticleRepository repository;
  SearchUsecase(this.repository);

  @override
  Future<Either<Failure, List<ArticleEntity>>> call({String? params}) async {
    return await repository.search(params!);
  }
}
