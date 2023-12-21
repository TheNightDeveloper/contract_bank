abstract class ArticleUsecase<Type, Params> {
  Future<Type> call({Params? params});
}
