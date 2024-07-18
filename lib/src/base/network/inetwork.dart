import "package:movie_night/src/base/network/network.dart";
import "package:movie_night/src/core/exceptions/exceptions.dart";

class Result<T, E> {
  final T? value;
  final E? error;

  Result.ok(this.value) : error = null;
  Result.error(this.error) : value = null;

  bool get isOk => value != null;
  bool get hasError => error != null;
}

Result<T, E> ok<T, E>(T? value) => Result.ok(value);
Result<T, E> error<T, E>(E? error) => Result.error(error);

abstract class INetwork {
  void init({
    required String baseUrl,
    String bearerToken = "",
  });

  Future<Result<R, NetworkException>> get<R>({
    required String url,
    Map<String, String>? queryParameters,
  });

  Future<Result<R, NetworkException>> post<B, R>({
    required String url,
    required B body,
  });

  Future<Result<R, NetworkException>> put<B, R>({
    required String url,
    required B body,
  });

  Future<Result<R, NetworkException>> delete<R>({
    required String url,
  });
}

INetwork getNetworkProvider({
  required String baseUrl,
  String bearerToken = "",
}) {
  final network = DioNetwork();
  network.init(baseUrl: baseUrl, bearerToken: bearerToken);
  return network;
}
