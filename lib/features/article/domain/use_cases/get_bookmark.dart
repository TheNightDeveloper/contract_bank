import 'package:contract_bank/core/services/data_state.dart';

import '../repositories/article_repository.dart';
import 'article_usecase.dart';

class GetBookmarkUsecase implements ArticleUsecase<DataState<List<int>>, void> {
  final ArticleRepository articleRepository;

  GetBookmarkUsecase(this.articleRepository);

  @override
  Future<DataState<List<int>>> call({void params}) async {
    return await articleRepository.getBookmark();
  }
}
