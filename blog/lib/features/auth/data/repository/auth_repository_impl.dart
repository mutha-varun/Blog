import 'package:blog/core/error/exceptions.dart';
import 'package:blog/core/error/failure.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog/features/auth/domain/entities/user.dart';
import 'package:blog/features/auth/domain/repository/auth_respository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRespository{

  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppFailure, User>> signInWithEmailPassword({
    required String email, 
    required String password
    }) async {
      return _getUser(
        ()=> remoteDataSource.signInWithEmailPassword(email: email, 
          password: password
        )
      );
  }

  @override
  Future<Either<AppFailure, User>> signUpWithEmailPassword({
    required String name, 
    required String email, 
    required String password}) async{
    
      return _getUser(
        () async => remoteDataSource.signUpWithEmailPassword(name: name, 
          email: email, 
          password: password
        )
      );
  }

  Future<Either<AppFailure, User>> _getUser(
    Future<User> Function() fn
  )async{
    try{
      final user = await fn();

      return Right(user);
    }
    on firebase_auth.FirebaseAuthException catch (e){
      return Left(AppFailure(e.message!));
    }
    on ServerException catch(e){
      return Left(AppFailure(e.message));
    }
  }
  
}