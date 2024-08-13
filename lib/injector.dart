import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:videoplayer/video_player/core/api_provider.dart';
import 'package:videoplayer/video_player/core/connection_checker.dart';

final sl = GetIt.instance;
Future<void> setUp() async {
  //core
  sl.registerLazySingleton<ApiProvider>(() => ApiProvider());
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  sl.registerLazySingleton<ConnectionChecker>(
      () => ConnectionCheckerImpl(sl()));
}
