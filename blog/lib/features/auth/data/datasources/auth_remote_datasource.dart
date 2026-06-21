import 'package:blog/core/error/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password
  });

  Future<String> signInWithEmailPassword({
    required String email,
    required String password
  });
} 

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{

  final firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> signInWithEmailPassword({required String email, required String password}) {
    

    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPassword({required String name, 
  required String email, 
  required String password}) async {
    try{
      final UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      userCredential.user!.updateDisplayName(name);

      if(userCredential.user == null){
        throw const ServerException("User is null");
      }
      
      return userCredential.user!.uid;
    }catch(e){
      throw ServerException(e.toString());
    }

  }
  
}
