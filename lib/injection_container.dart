import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:montageapp/core/network/network_info.dart';
import 'package:montageapp/features/random_user/data/data_source/user_remote_data_source.dart';
import 'package:montageapp/features/random_user/data/repository/user_repository_impl.dart';
import 'package:montageapp/features/random_user/domain/repository/user_repository.dart';
import 'package:montageapp/features/random_user/domain/use_case/get_user.dart';
import 'package:montageapp/features/random_user/presentation/bloc/user_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => UserBloc(user: sl()));

  sl.registerLazySingleton(() => GetUser(sl()));

  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));

  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton(() => DataConnectionChecker());
}
