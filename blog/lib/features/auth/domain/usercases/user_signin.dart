import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/usecase.dart';

import 'package:blog/features/auth/domain/entities/user.dart';
import 'package:blog/features/auth/domain/repository/auth_respository.dart';
import 'package:fpdart/fpdart.dart';


class UserSignin implements Usecase<User, UserSigninParams>{
  final AuthRespository authRespository;

  const UserSignin(this.authRespository); 
  
  @override
  Future<Either<AppFailure, User>> call(UserSigninParams params) async {
    return await authRespository.signInWithEmailPassword(
      email: params.email,
      password: params.password
    );
  }

}
  

class UserSigninParams{
  final String email;
  final String password;

  UserSigninParams({
    required this.email, 
    required this.password
  });
  
}