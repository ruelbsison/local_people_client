import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/auth.dart';
//import 'package:local_people_core/splash.dart';
import 'package:local_people_core/login.dart';

final sl = GetIt.instance; //sl is referred to as Service Locator

//Dependency injection
Future<void> init() async {
  //Blocs
  // sl.registerFactory(
  //       () => AuthenticationBloc(
  //           authenticationRepository: sl(),
  //       )..add(AppStarted()),
  // );
  //
  // //Use cases
  // /*sl.registerLazySingleton(() => LoginUser(repository: sl()));
  // sl.registerLazySingleton(() => FetchToken(repository: sl()));
  // sl.registerLazySingleton(() => LogOutUser(repository: sl()));
  // sl.registerLazySingleton(() => ChangePassword(repository: sl()));*/
  //
  // //Repositories
  // sl.registerLazySingleton<AuthenticationRepository>(
  //       () => AuthenticationRepositoryImpl(
  //         authLocalDataSource: sl(),
  //   ));
  //
  // //Data sources
  // sl.registerLazySingleton<AuthLocalDataSource>(
  //       () => AuthLocalDataSourceImpl(
  //         authorizationConfig: sl(),
  //   ),
  // );
  //
  // sl.registerLazySingleton<UserRestApiClient>(
  //       () => UserRestApiClient(
  //           Dio(BaseOptions(contentType: "application/json"))
  //   ),
  // );
  //
  // sl.registerLazySingleton<UserRemoteDataSource>(
  //       () => UserRemoteDataSourceImpl(
  //           userRestApiClient: sl(),
  //   ),
  // );
  //
  // sl.registerLazySingleton<AuthorizationConfig>(
  //       () => AuthorizationConfig.devClientAuthorizationConfig(),
  // );
  //
  // //Core
  // sl.registerLazySingleton<NetworkInfo>(
  //       () => NetworkInfoImpl(dataConnectionChecker: sl()),
  // );

}