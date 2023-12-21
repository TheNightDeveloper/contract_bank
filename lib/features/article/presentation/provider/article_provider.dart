import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:contract_bank/core/errors/failure.dart';
import 'package:contract_bank/core/services/data_state.dart';
import 'package:contract_bank/features/article/domain/use_cases/delete_bookmark.dart';
import 'package:contract_bank/features/article/domain/use_cases/get_bookmark.dart';
import 'package:contract_bank/features/article/domain/use_cases/post_bookmark.dart';
import 'package:contract_bank/features/article/domain/use_cases/search.dart';

import '../../domain/entities/article_entity.dart';
import '../../domain/use_cases/get_article.dart';

class ArticleProvider extends ChangeNotifier with EquatableMixin {
  List<ArticleEntity>? allArticle = [];
  List<ArticleEntity>? bookmarkArticle = [];
  List<ArticleEntity>? searchList = [];
  DioException? exception;
  Failure? failure;
  bool isLoading = false;

//// DEPENDENCIES ////
  final PostBookmarkUsecase _postBookmarkUsecase;
  final DeleteBookmarkUsecase _deleteBookmarkUsecase;
  final SearchUsecase _searchUsecase;
  final GetArticleUsecase _getArticleUsecase;
  final GetBookmarkUsecase _getBookmarkUsecase;
  ArticleProvider({
    required GetArticleUsecase getArticleUsecase,
    required GetBookmarkUsecase getBookmarkUsecase,
    required PostBookmarkUsecase postBookmarkUsecase,
    required DeleteBookmarkUsecase deleteBookmarkUsecase,
    required SearchUsecase searchUsecase,
  })  : _getArticleUsecase = getArticleUsecase,
        _getBookmarkUsecase = getBookmarkUsecase,
        _deleteBookmarkUsecase = deleteBookmarkUsecase,
        _postBookmarkUsecase = postBookmarkUsecase,
        _searchUsecase = searchUsecase;
//// FUNCTIONS  ////

  Future<void> fetchData() async {
    try {
      getArticle();
      getBookmark();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getArticle() async {
    allArticle!.clear();
    final dataState = await _getArticleUsecase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      allArticle = dataState.data!;
      print('done');
      // sortLaws(dataState.data!);
      notifyListeners();
    } else {
      exception = dataState.exception!;
      print(exception);
      notifyListeners();
    }
  }

  Future<void> getBookmark() async {
    bookmarkArticle!.clear();
    List<int> dataRecieved;
    final dataState = await _getBookmarkUsecase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      dataRecieved = dataState.data!;

      /// CHECK WHICH OF ARTICLES ID IS EQUAL TO DATA RECIEVED IDs
      for (var article in allArticle!) {
        for (var id in dataRecieved) {
          if (article.id == id) {
            if (!bookmarkArticle!.contains(article)) {
              bookmarkArticle!.add(article);
            }
          }
        }
      }
      print('get bookmark done');
      notifyListeners();
    } else {
      exception = dataState.exception!;
      print(exception);
      notifyListeners();
    }
  }

  Future<void> postBookmark(int id) async {
    final failureOrBool = await _postBookmarkUsecase.call(params: id);
    failureOrBool.fold((fail) => Fluttertoast.showToast(msg: fail.errorMessage),
        (bool) {
      Fluttertoast.showToast(msg: 'قرارداد نشان شد');
      getBookmark();
    });
  }

  Future<void> deleteBookmark(String id) async {
    final failureOrDelete = await _deleteBookmarkUsecase.call(params: id);
    failureOrDelete.fold(
        (fail) => Fluttertoast.showToast(msg: fail.errorMessage), (delete) {
      if (delete == 'bookmark deleted') {
        bookmarkArticle!.removeWhere((element) => element.id == int.parse(id));
        Fluttertoast.showToast(msg: 'مقاله از نشان شده ها حذف شد');
      } else if (delete == 'bookmark noting') {
        Fluttertoast.showToast(msg: 'مقاله از نشان شده ها حذف شده است');
      }
    });
    notifyListeners();
  }

  Future<void> search(String key) async {
    loading();
    final failureOrArticle = await _searchUsecase.call(params: key);
    failureOrArticle
        .fold((fail) => Fluttertoast.showToast(msg: fail.errorMessage), (list) {
      // print('search success');
      // print(list);
      searchList = list;
      isLoading = false;
      notifyListeners();
    });
  }

  void loading() {
    isLoading = true;
    notifyListeners();
  }

  @override
  List<Object?> get props => [allArticle, bookmarkArticle, searchList];
}

/*
  // List<ArticleEntity>? sakhtSaz = [];
  // List<ArticleEntity>? mosharekat = [];
  // List<ArticleEntity>? estekhdam = [];
  // List<ArticleEntity>? mohafezat = [];
  // List<ArticleEntity>? peymankari = [];
  // List<ArticleEntity>? kharidForosh = [];
  // List<ArticleEntity>? malekiat = [];
  // List<ArticleEntity>? ejare = [];
  // List<ArticleEntity>? sayer = [];

  void sortLaws(List<ArticleEntity> allArticles) {
    for (var article in allArticles) {
      switch (article.category['id']) {
        case 1:
          sakhtSaz!.add(article);
        case 2:
          mosharekat!.add(article);
        case 3:
          estekhdam!.add(article);
        case 4:
          mohafezat!.add(article);
        case 5:
          peymankari!.add(article);
        case 6:
          kharidForosh!.add(article);
        case 7:
          malekiat!.add(article);
        case 8:
          ejare!.add(article);
        case 9:
          sayer!.add(article);
      }
      notifyListeners();
    }
    // sakhtSaz =
    //     allArticle!.where((article) => article.category['id'] == 1).toList();
    // mosharekat =
    //     allArticles.where((article) => article.category['id'] == 2).toList();
    // estekhdam =
    //     allArticles.where((article) => article.category['id'] == 3).toList();
    // mohafezat =
    //     allArticles.where((article) => article.category['id'] == 4).toList();
    //     peymankari = allArticles.where((article) => article.category['id'] == 5).toList();
    //     kharidForosh =allArticles.where((article) => article.category['id'] == 6).toList();
    //     malekiat=allArticles.where((article) => article.category['id'] == 7).toList();
    //     ejare=allArticles.where((article) => article.category['id'] == 8).toList();
    //     sayer=allArticles.where((article) => article.category['id'] == 9).toList();
  }

  */
