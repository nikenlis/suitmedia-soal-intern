

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:suitmedia/third_page/presentation/bloc/all_user_bloc.dart';

import 'core/platform/network_info.dart';
import 'third_page/data/datasources/user_local_data_source.dart';
import 'third_page/data/datasources/user_remote_data_source.dart';
import 'third_page/data/repositories/user_repository_impl.dart';
import 'third_page/domain/repositories/user_repository.dart';
import 'third_page/domain/usecases/get_all_user_usecase.dart';


final locator = GetIt.instance;

Future<void> initLocator() async{
  //bloc 
  locator.registerFactory(() => AllUserBloc(locator()));


  //usecase
  locator.registerLazySingleton(() => GetAllUserUsecase(locator()));

  //repository
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(networkInfo: locator(), localDataSource: locator(), remoteDataSource: locator()));

  //datasource
  locator.registerLazySingleton<UserLocalDataSource>(() => UserLocalDataSourceImpl(pref: locator()));
  locator.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(client: locator()));

  //platform
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectivity: locator()));

  //external
  final pref = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => pref);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => Connectivity());

}