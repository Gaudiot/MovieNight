import "package:dio/dio.dart";
import "package:movie_night/src/base/network/network.dart";
import "package:movie_night/src/core/exceptions/exceptions.dart";

final dio = Dio();

class DioNetwork implements INetwork {
  Future<Result<R, NetworkException>> _handleDioRequest<R>(
    Future<Response<R>> Function() request,
  ) async {
    try {
      final response = await request();

      return ok(response.data);
    } on DioException catch (e) {
      return error(
        NetworkException(
          message: e.message,
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return error(NetworkException(message: e.toString()));
    }
  }

  @override
  Future<Result<R, NetworkException>> delete<R>(String url) async {
    return _handleDioRequest<R>(() => dio.delete<R>(url));
  }

  @override
  Future<Result<R, NetworkException>> get<R>(
    String url,
    Map<String, String> queryParameters,
  ) async {
    return _handleDioRequest<R>(
      () => dio.get<R>(url, queryParameters: queryParameters),
    );
  }

  @override
  Future<Result<R, NetworkException>> post<B, R>(String url, B body) async {
    return _handleDioRequest<R>(() => dio.post<R>(url, data: body));
  }

  @override
  Future<Result<R, NetworkException>> put<B, R>(String url, B body) async {
    return _handleDioRequest<R>(() => dio.put<R>(url, data: body));
  }
}
