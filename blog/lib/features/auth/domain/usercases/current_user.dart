import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/core/common/entities/user.dart';
import 'package:blog/features/auth/domain/repository/auth_respository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements Usecase<User, NoParams> {
  final AuthRespository authRespository;

  CurrentUser(this.authRespository);
  @override
  Future<Either<AppFailure, User>> call(params) async {
    return await authRespository.currentUser();
  }

}

