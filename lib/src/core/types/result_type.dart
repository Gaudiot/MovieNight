class Result<T, E> {
  final T? value;
  final E? error;

  Result.ok(this.value) : error = null;
  Result.error(this.error) : value = null;

  bool get isOk => value != null;
  bool get hasError => error != null;
}
