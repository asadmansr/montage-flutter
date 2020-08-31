import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:montageapp/core/database/database_helper.dart';
import 'package:montageapp/core/network/network_info.dart';
import 'package:montageapp/features/random_user/data/data_source/user_local_data_source.dart';
import 'package:montageapp/features/random_user/data/data_source/user_remote_data_source.dart';
import 'package:montageapp/features/random_user/data/repository/user_repository_impl.dart';
import 'package:montageapp/features/random_user/domain/repository/user_repository.dart';
import 'package:montageapp/features/random_user/domain/use_case/get_user.dart';
import 'package:montageapp/features/random_user/presentation/bloc/user_bloc.dart';

import 'features/random_user/domain/use_case/save_user.dart';
import 'features/user_list/data/data_source/user_list_local_data_source.dart';
import 'features/user_list/data/repository/user_list_repository_impl.dart';
import 'features/user_list/domain/repository/user_list_repository.dart';
import 'features/user_list/domain/use_case/get_user_list.dart';
import 'features/user_list/presentation/bloc/user_list_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => UserBloc(getUser: sl(), saveUser: sl()));
  sl.registerFactory(() => UserListBloc(userList: sl()));

  sl.registerLazySingleton(() => GetUser(sl()));
  sl.registerLazySingleton(() => SaveUser(sl()));
  sl.registerLazySingleton(() => GetUserList(sl()));

  final databaseHelper = DatabaseHelper.instance;
  sl.registerLazySingleton(() => databaseHelper);

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()));
  sl.registerLazySingleton<UserListRepository>(
      () => UserListRepositoryImpl(userListLocalDataSource: sl()));

  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(client: sl()));
  sl.registerLazySingleton<UserListLocalDataSource>(
      () => UserListLocalDataSourceImpl(client: sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton(() => DataConnectionChecker());
}
