import 'package:blog/core/error/failure.dart';
import 'package:blog/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRespository {
    Future<Either<AppFailure, User>> signUpWithEmailPassword({
      required String name,
      required String email,
      required String password
    });

    Future<Either<AppFailure, User>> signInWithEmailPassword({
      required String email,
      required String password
    });
}