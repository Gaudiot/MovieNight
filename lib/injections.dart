import "package:get_it/get_it.dart";
import "package:movie_night/src/base/local_storage/local_storage.dart";
import "package:movie_night/src/base/network/network.dart";

GetIt getIt = GetIt.instance;

void setupInjections() {
  getIt.registerSingleton<ILocalStorage>(HiveStorage());
  getIt.registerSingleton<INetwork>(DioNetwork());
}
