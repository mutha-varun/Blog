import 'package:blog/core/error/exceptions.dart';
import 'package:blog/core/error/failure.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog/features/auth/domain/repository/auth_respository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRespository{

  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppFailure, String>> signInWithEmailPassword({required String email, required String password}) {


    throw UnimplementedError();
  }

  @override
  Future<Either<AppFailure, String>> signUpWithEmailPassword({
    required String name, 
    required String email, 
    required String password}) async{
    try{
      final uid = await remoteDataSource.signUpWithEmailPassword(name: name, email: email, password: password);
      
      return Right(uid);
    }on ServerException catch(e){
      return Left(AppFailure(e.message));
    }
  }

}