import 'package:dartz/dartz.dart';
import 'package:contracts_bank/core/errors/failure.dart';
import 'package:contracts_bank/features/article/domain/entities/article_entity.dart';

import '../../../../core/services/data_state.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getArticle();
  Future<DataState<List<int>>> getBookmark();
  Future<Either<Failure, bool>> postBookmark(int id);
  Future<Either<Failure, String>> deleteBookmark(String id);
  Future<Either<Failure, List<ArticleEntity>>> search(String key);
}
