// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_remote_data.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ArticleRemoteData implements ArticleRemoteData {
  _ArticleRemoteData(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://majidmovahedi.liara.run/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<List<ArticleModel>>> getArticle(
      ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = HEADER_URL;
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<HttpResponse<List<ArticleModel>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'articles/law/',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) => ArticleModel.fromJson(i as Map<String, dynamic>))
        .toList();
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<List<int>>> getBookmark(
      ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = HEADER_URL;
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<HttpResponse<List<int>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'articles/bookmark',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = _result.data!.map((e) => e['article'] as int).toList();
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<dynamic>> postBookmark(
      {int? id}) async {
    final _data = {"article": id};
    final _headers = HEADER_URL;
    final _result = await _dio.post('${baseUrl}articles/bookmark',
        data: jsonEncode(_data), options: Options(headers: _headers));
    /* const _extra = <String, dynamic>{};
    const queryParameters = null;
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA3NTc3MTgzLCJpYXQiOjE3MDIzOTMxODMsImp0aSI6IjE5MDhiZTcwMDJlODQ3ODM4MjA2YmVmZDJjNzRjMGNmIiwidXNlcl9pZCI6MTV9.VPHeJRnR5T-pL_AvmNAeijPJKsFleUdtAzwQnlF5sIY'
    };
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic> _data = {"article": id};
    final _result =
        await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'articles/bookmark',
              queryParameters: queryParameters,
              data: json.encode(_data),
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));*/

    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<dynamic>> deleteBookmark(
      {String? id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = HEADER_URL;
    const _data = null;
    print('${baseUrl}articles/bookmark_delete/$id/');
    final _result = await _dio.delete('${baseUrl}articles/bookmark_delete/$id/',
        options: Options(headers: _headers));

    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<List<ArticleModel>>> search(
      {String? key}) async {
    final _headers = HEADER_URL;

    final Map<String, dynamic>? _data = {'key': key};

    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<HttpResponse<List<ArticleModel>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: null,
    )
            .compose(
              _dio.options,
              '/articles/search',
              queryParameters: null,
              data: jsonEncode(_data),
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) => ArticleModel.fromJson(i as Map<String, dynamic>))
        .toList();
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
