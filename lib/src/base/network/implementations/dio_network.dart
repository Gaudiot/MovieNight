import "package:dio/dio.dart";
import "package:movie_night/src/base/network/network.dart";
import "package:movie_night/src/core/exceptions/exceptions.dart";
import "package:movie_night/src/core/types/result_type.dart";

class DioNetwork implements INetwork {
  late final Dio _dio;

  Dio get dio => _dio;

  @override
  void init({
    required String baseUrl,
    String bearerToken = "",
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        responseType: ResponseType.json,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          "authorization": "Bearer $bearerToken",
        },
      ),
    );
  }

  Future<Result<R, NetworkException>> _handleDioRequest<R>(
    Future<Response<R>> Function() request,
  ) async {
    try {
      final response = await request();

      return ok(response.data);
    } on DioException catch (e) {
      return error(
        NetworkException(
          message: "dio error: ${e.message}",
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return error(
          NetworkException(message: "unknown network error: ${e.toString()}"));
    }
  }

  @override
  Future<Result<R, NetworkException>> get<R>({
    required String url,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  }) async {
    return _handleDioRequest<R>(
      () => dio.get(
        url,
        queryParameters: queryParameters,
      ),
    );
  }

  @override
  Future<Result<R, NetworkException>> delete<R>({
    required String url,
  }) async {
    return _handleDioRequest(
      () => dio.delete(url),
    );
  }

  @override
  Future<Result<R, NetworkException>> post<B, R>({
    required String url,
    required B body,
    Map<String, String>? headers,
  }) async {
    return _handleDioRequest<R>(
      () => dio.post(
        url,
        data: body,
      ),
    );
  }

  @override
  Future<Result<R, NetworkException>> put<B, R>({
    required String url,
    required B body,
    Map<String, String>? headers,
  }) async {
    return _handleDioRequest<R>(
      () => dio.put(
        url,
        data: body,
      ),
    );
  }
}
