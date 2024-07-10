import "package:flutter/material.dart";
import "package:hive/hive.dart";
import "package:movie_night/src/base/local_storage/ilocal_storage.dart";
import "package:path_provider/path_provider.dart";

class HiveStorage implements ILocalStorage {
  @override
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final dir = await getApplicationDocumentsDirectory();
    Hive.defaultDirectory = dir.path;
  }

  @override
  Future<T?> getItem<T>(String collection, String key) async {
    final boxCollection = Hive.box<T>(name: collection);

    final item = boxCollection.get(key);

    return item;
  }

  @override
  Future<void> removeItem(String collection, String key) async {
    final boxCollection = Hive.box(name: collection);

    boxCollection.delete(key);
  }

  @override
  Future<void> setItem<T>(String collection, String key, T value) async {
    final boxCollection = Hive.box<T>(name: collection);

    boxCollection.put(key, value);
  }

  @override
  Future<void> clearCollection(String collection) async {
    final boxCollection = Hive.box(name: collection);

    boxCollection.clear();
  }
}
