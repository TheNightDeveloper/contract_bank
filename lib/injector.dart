import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:contract_bank/features/article/data/data_source/remote_data/article_remote_data.dart';
import 'package:contract_bank/features/article/data/repositories/article_repository_impl.dart';
import 'package:contract_bank/features/article/domain/repositories/article_repository.dart';
import 'package:contract_bank/features/article/domain/use_cases/delete_bookmark.dart';
import 'package:contract_bank/features/article/domain/use_cases/get_article.dart';
import 'package:contract_bank/features/article/domain/use_cases/get_bookmark.dart';
import 'package:contract_bank/features/article/domain/use_cases/post_bookmark.dart';
import 'package:contract_bank/features/article/domain/use_cases/search.dart';
import 'package:contract_bank/features/article/presentation/provider/article_provider.dart';
import 'package:contract_bank/features/auth/data/data_sources/auth_remote_data.dart';
import 'package:contract_bank/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:contract_bank/features/auth/domain/repositories/auth_repository.dart';
import 'package:contract_bank/features/auth/domain/use_cases/login_usecase.dart';
import 'package:contract_bank/features/auth/domain/use_cases/newpassword_usecase.dart';
import 'package:contract_bank/features/auth/domain/use_cases/otp_usecase.dart';
import 'package:contract_bank/features/auth/domain/use_cases/register_usecase.dart';
import 'package:contract_bank/features/auth/domain/use_cases/verify_usecase.dart';
import 'package:contract_bank/features/auth/presentation/provider/auth_provider.dart';

GetIt sl = GetIt.instance;
injectionSetup() {
  sl.registerSingleton<Dio>(Dio());
  ////// DATA SOURCE ////

  sl.registerLazySingleton<AuthRemoteData>(() => AuthRemoteDataImpl(sl()));
  sl.registerLazySingleton<ArticleRemoteData>(() => ArticleRemoteData(sl()));

  //// REPOSITORIES /////
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteData: sl()));
  sl.registerLazySingleton<ArticleRepository>(
      () => ArticleRepositoryImpl(sl()));

  //// USE CASES ////
  sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(sl()));
  sl.registerLazySingleton<RegisterUsecase>(() => RegisterUsecase(sl()));
  sl.registerLazySingleton<VerifyUsecase>(() => VerifyUsecase(sl()));
  sl.registerLazySingleton<OtpUsecase>(() => OtpUsecase(sl()));
  sl.registerLazySingleton<NewpasswordUsecase>(() => NewpasswordUsecase(sl()));

  sl.registerLazySingleton<GetArticleUsecase>(() => GetArticleUsecase(sl()));
  sl.registerLazySingleton<GetBookmarkUsecase>(() => GetBookmarkUsecase(sl()));
  sl.registerLazySingleton<PostBookmarkUsecase>(
      () => PostBookmarkUsecase(sl()));
  sl.registerLazySingleton<DeleteBookmarkUsecase>(
      () => DeleteBookmarkUsecase(sl()));
  sl.registerLazySingleton<SearchUsecase>(() => SearchUsecase(sl()));

  //// PROVIDERS ////
  sl.registerLazySingleton<AuthProvider>(() => AuthProvider(
      loginUsecase: sl(),
      registerUsecase: sl(),
      verifyUsecase: sl(),
      otpUsecase: sl(),
      newpasswordUsecase: sl()));

  sl.registerSingleton<ArticleProvider>(ArticleProvider(
      getArticleUsecase: sl(),
      getBookmarkUsecase: sl(),
      postBookmarkUsecase: sl(),
      deleteBookmarkUsecase: sl(),
      searchUsecase: sl()));
  // sl.registerLazySingleton<ArticleProvider>(() => ArticleProvider(
  //     getArticleUsecase: sl(),
  //     getBookmarkUsecase: sl(),
  //     postBookmarkUsecase: sl(),
  //     deleteBookmarkUsecase: sl(),
  //     searchUsecase: sl()));
}
