// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) => ArticleModel(
      id: json['id'] as int,
      category: json['category'] as Map<String, dynamic>,
      title: json['title'] as String,
      main_title: json['main_title'] as String,
      law_number: json['law_number'] as int,
      content: json['content'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'title': instance.title,
      'main_title': instance.main_title,
      'law_number': instance.law_number,
      'content': instance.content,
      'url': instance.url,
    };
