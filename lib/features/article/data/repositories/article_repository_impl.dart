import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:contract_bank/core/errors/failure.dart';
import 'package:contract_bank/core/services/data_state.dart';
import 'package:contract_bank/features/article/data/data_source/remote_data/article_remote_data.dart';
import 'package:contract_bank/features/article/data/models/article_model.dart';
import 'package:contract_bank/features/article/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteData remoteData;
  ArticleRepositoryImpl(this.remoteData);
  @override
  Future<DataState<List<ArticleModel>>> getArticle() async {
    try {
      final httpResponse = await remoteData.getArticle();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<int>>> getBookmark() async {
    try {
      final httpResponse = await remoteData.getBookmark();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<Either<Failure, String>> deleteBookmark(String id) async {
    try {
      final httpResponse = await remoteData.deleteBookmark(id: id);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        print(httpResponse.response.statusMessage!);
        return Right(httpResponse.response.data);
      } else {
        return Left(
            ServerFailure(errorMessage: httpResponse.response.statusMessage!));
      }
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'delete bookmark fail'));
    }
  }

  @override
  Future<Either<Failure, bool>> postBookmark(int id) async {
    try {
      final httpResponse = await remoteData.postBookmark(id: id);
      if (httpResponse.response.statusCode == HttpStatus.created) {
        return const Right(true);
      } else {
        return Left(BookmarkFailure(
            errorMessage: httpResponse.response.statusMessage!));
      }
    } catch (e) {
      return Left(BookmarkFailure(errorMessage: 'bookmark fail'));
    }
  }

  @override
  Future<Either<Failure, List<ArticleModel>>> search(String key) async {
    try {
      final httpResponse = await remoteData.search(key: key);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return Right(httpResponse.data);
      } else {
        return Left(
            SerachFailure(errorMessage: httpResponse.response.statusMessage!));
      }
    } catch (e) {
      return Left(SerachFailure(errorMessage: 'search fail'));
    }
  }
}
