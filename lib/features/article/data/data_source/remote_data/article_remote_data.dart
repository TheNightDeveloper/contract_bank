import 'dart:convert';
import 'package:dio/dio.dart' hide Headers;
import 'package:contracts_bank/config/routes/routes.dart';
import 'package:contracts_bank/core/utils/const.dart';
import 'package:retrofit/retrofit.dart';
import 'package:contracts_bank/features/article/data/models/article_model.dart';

part 'article_remote_data.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class ArticleRemoteData {
  factory ArticleRemoteData(Dio dio) = _ArticleRemoteData;

  @GET('articles/law/')
  Future<HttpResponse<List<ArticleModel>>> getArticle();

  @GET('articles/bookmark')
  Future<HttpResponse<List<int>>> getBookmark();

  @POST('articles/bookmark')
  Future<HttpResponse> postBookmark({@Query("article") int? id});

  @DELETE('/articles/bookmark_delete')
  Future<HttpResponse> deleteBookmark({String? id});

  @POST('/articles/search')
  Future<HttpResponse<List<ArticleModel>>> search({@Query("key") String? key});
}

// class ContentRemoteDataImpl extends ArticleRemoteData {
//   final Dio dio;
//   ContentRemoteDataImpl(this.dio);
//   @override
//   Future<ContentModel> getContent({required contentParams})async {
//     final response =await dio.get(BASE_URL,);
//     if(response.statusCode==200){
//       ContentModel.
//     }
//     // TODO: implement getContent
//     throw UnimplementedError();
//   }
// }
