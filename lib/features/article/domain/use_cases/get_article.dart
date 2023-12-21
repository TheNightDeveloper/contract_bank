import 'package:contract_bank/core/services/data_state.dart';
import 'package:contract_bank/features/article/domain/entities/article_entity.dart';
import 'package:contract_bank/features/article/domain/repositories/article_repository.dart';
import 'package:contract_bank/features/article/domain/use_cases/article_usecase.dart';

class GetArticleUsecase
    implements ArticleUsecase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository articleRepository;

  GetArticleUsecase(this.articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) async {
    return await articleRepository.getArticle();
  }
}
