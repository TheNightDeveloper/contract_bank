import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/article_entity.dart';
part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel extends ArticleEntity {
  final int id;
  final Map<String, dynamic> category;
  final String title;
  final String main_title;
  final int law_number;
  final String content;
  final String url;
  ArticleModel(
      {required this.id,
      required this.category,
      required this.title,
      required this.main_title,
      required this.law_number,
      required this.content,
      required this.url})
      : super(
            id: id,
            category: category,
            title: title,
            main_title: main_title,
            law_number: law_number,
            content: content,
            url: url);

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

  // String toJsonString() => jsonEncode(toJson());
  //
  // static ArticleModel fromJsonString(String jsonString) =>
  //     ArticleModel.fromJson(jsonDecode(jsonString));
}
