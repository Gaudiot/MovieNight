import "package:get_it/get_it.dart";
import "package:movie_night/src/base/local_storage/local_storage.dart";

GetIt getIt = GetIt.instance;

void setupInjections() {
  getIt.registerSingleton<ILocalStorage>(HiveStorage());
}
