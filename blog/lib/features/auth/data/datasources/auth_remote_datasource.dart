import 'package:blog/core/error/exceptions.dart';
import 'package:blog/features/auth/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;


abstract interface class AuthRemoteDataSource {
  fba.User? get currentUser;

  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password
  });

  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password
  });

  Future<UserModel?> getCurrentUserData();
} 

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{

  final firebaseAuth = fba.FirebaseAuth.instance;

  @override
  
  fba.User? get currentUser => firebaseAuth.currentUser;

  @override
  Future<UserModel> signInWithEmailPassword({required String email, required String password}) async{
    try{

      final fba.UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

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
      final fba.UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

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
  
  @override
  Future<UserModel?> getCurrentUserData() async{
    try{
      if(firebaseAuth.currentUser != null){
        final user = firebaseAuth.currentUser;
        final map = {
          'id': user!.uid,
          'email': user.email,
          'name': user.displayName
        };
        return UserModel.fromJson(map);
      }

      return null;
      
    }catch(e){
      throw ServerException(e.toString());
    }
    
  }
}
