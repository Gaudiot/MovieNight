typedef Result<T, E> = (T?, E?);

Result<T, E> ok<T, E>(T? value) => (value, null);
Result<T, E> error<T, E>(E? error) => (null, error);

abstract class INetwork {
  Future<Result<R, Exception>> get<R>(
    String url,
    Map<String, String> queryParameters,
  );
  Future<Result<R, Exception>> post<B, R>(String url, B body);
  Future<Result<R, Exception>> put<B, R>(String url, B body);
  Future<Result<R, Exception>> delete<R>(String url);
}
