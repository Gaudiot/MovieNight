abstract class ILocalStorage {
  Future<void> init();
  Future<void> setItem<T>(String collection, String key, T value);
  Future<T?> getItem<T>(String collection, String key);
  Future<void> removeItem(String collection, String key);
  Future<void> clear();
}
