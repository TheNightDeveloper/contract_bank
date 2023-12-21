import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final int id;
  final Map<String, dynamic> category;
  final String title;
  final String main_title;
  final int law_number;
  final String content;
  final String url;

  ArticleEntity(
      {required this.id,
      required this.category,
      required this.title,
      required this.main_title,
      required this.law_number,
      required this.content,
      required this.url});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, category, title, main_title, law_number, content, url];
}
