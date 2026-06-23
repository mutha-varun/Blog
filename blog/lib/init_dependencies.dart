import 'package:blog/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog/features/auth/domain/repository/auth_respository.dart';
import 'package:blog/features/auth/domain/usercases/user_signin.dart';
import 'package:blog/features/auth/domain/usercases/user_signup.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;


Future<void> initDependencies() async{
  _initAuth();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  ); 
}

void _initAuth(){
  serviceLocator.registerFactory<AuthRemoteDataSource>(()=> AuthRemoteDataSourceImpl());
  serviceLocator.registerFactory<AuthRespository>(()=> AuthRepositoryImpl(serviceLocator()));
  serviceLocator.registerFactory(()=> UserSignup(serviceLocator()));
  serviceLocator.registerFactory(()=> UserSignin(serviceLocator()));

  serviceLocator.registerLazySingleton(
    ()=> AuthBloc(
      userSignup: serviceLocator(),
      userSignin: serviceLocator()
    )
  );
}