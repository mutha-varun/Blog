import 'package:blog/core/error/exceptions.dart';
import 'package:blog/features/auth/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password
  });

  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password
  });
} 

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{

  final firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserModel> signInWithEmailPassword({required String email, required String password}) async{
    try{

      final UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      if(userCredential.user == null){
        throw const ServerException("User is null");
      }

      var map = {
        'id': userCredential.user!.uid,
        "email": userCredential.user!.email,
        "name": userCredential.user!.displayName
      }; 

      return UserModel.fromJson(map);
      
    }catch(e){
      throw ServerException(e.toString());
    }
    
  }

  @override
  Future<UserModel> signUpWithEmailPassword({required String name, 
  required String email, 
  required String password}) async {
    try{
      final UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      userCredential.user!.updateDisplayName(name);

      if(userCredential.user == null){
        throw const ServerException("User is null");
      }

      var map = {
        'id': userCredential.user!.uid,
        "email": userCredential.user!.email,
        "name": userCredential.user!.displayName
      };
      
      return UserModel.fromJson(map);
    }catch(e){
      throw ServerException(e.toString());
    }

  }
  
}
