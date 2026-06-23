// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/domain/entities/user.dart';
import 'package:blog/features/auth/domain/repository/auth_respository.dart';

import 'package:fpdart/fpdart.dart';


class UserSignup implements Usecase<User, UserSignupParameters>{

  final AuthRespository authRespository;

  const UserSignup(this.authRespository); 

  @override
  Future<Either<AppFailure, User>> call(UserSignupParameters params) async{
    return await authRespository.signUpWithEmailPassword(
      name: params.name, 
      email: params.email, 
      password: params.password
    );
  }
}


class UserSignupParameters {
  final String email;
  final String name;
  final String password;
  UserSignupParameters({
    required this.email,
    required this.name,
    required this.password,
  });
}
