import 'package:dartz/dartz.dart';
import 'package:contract_bank/core/errors/failure.dart';
import 'package:contract_bank/features/article/domain/repositories/article_repository.dart';
import 'package:contract_bank/features/article/domain/use_cases/article_usecase.dart';

class PostBookmarkUsecase
    implements ArticleUsecase<Either<Failure, bool>, int> {
  final ArticleRepository articleRepository;
  PostBookmarkUsecase(this.articleRepository);
  @override
  Future<Either<Failure, bool>> call({int? params}) async {
    return await articleRepository.postBookmark(params!);
  }
}
