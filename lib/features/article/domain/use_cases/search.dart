import 'package:dartz/dartz.dart';
import 'package:contract_bank/core/errors/failure.dart';
import 'package:contract_bank/features/article/domain/entities/article_entity.dart';
import 'package:contract_bank/features/article/domain/repositories/article_repository.dart';
import 'package:contract_bank/features/article/domain/use_cases/article_usecase.dart';

class SearchUsecase
    implements ArticleUsecase<Either<Failure, List<ArticleEntity>>, String> {
  final ArticleRepository repository;
  SearchUsecase(this.repository);

  @override
  Future<Either<Failure, List<ArticleEntity>>> call({String? params}) async {
    return await repository.search(params!);
  }
}
