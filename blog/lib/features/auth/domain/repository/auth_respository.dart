import 'package:blog/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRespository {
    Future<Either<AppFailure, String>> signUpWithEmailPassword({
      required String name,
      required String email,
      required String password
    });

    Future<Either<AppFailure, String>> signInWithEmailPassword({
      required String email,
      required String password
    });
}