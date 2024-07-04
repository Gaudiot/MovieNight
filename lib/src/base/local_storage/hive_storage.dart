import 'package:hive/hive.dart';
import 'package:movie_night/src/base/local_storage/ilocal_storage.dart';

class HiveStorage implements ILocalStorage {
  @override
  Future<void> init() async {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<T?> getItem<T>(String collection, String key) async {
    final boxCollection = Hive.box(collection);

    final item = await boxCollection.get(key) as T?;

    return item;
  }

  @override
  Future<void> removeItem(String collection, String key) async {
    // TODO: implement removeItem
    throw UnimplementedError();
  }

  @override
  Future<void> setItem<T>(String collection, String key, T value) async {
    // TODO: implement setItem
    throw UnimplementedError();
  }

  @override
  Future<void> clear() async {
    // TODO: implement clear
    throw UnimplementedError();
  }
}
