import 'package:blog/features/auth/domain/entities/user.dart';
import 'package:blog/features/auth/domain/usercases/user_signin.dart';
import 'package:blog/features/auth/domain/usercases/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserSignin _userSignin;
  
  AuthBloc({
    required UserSignup userSignup,
    required UserSignin userSignin
  }) : _userSignup = userSignup,
    _userSignin = userSignin ,
    super(AuthInitial()) {
      
    on<AuthSignUp>(_onAuthSignUp);

    on<AuthSignIn>(_onAuthSignIn);
  }


  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async{
    emit(AuthLoading()); 
    final res = await _userSignup(UserSignupParameters(
      email: event.email, 
      name: event.name, 
      password: event.password
    ));
    res.fold(
      (l) => emit(AuthFailure(l.message)), 
      (user)=> emit(AuthSuccess(user))
    );
  }


  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async{
    emit(AuthLoading());

    final res = await _userSignin(UserSigninParams(email: event.email, 
      password: event.password
    ));

    res.fold(
      (l) => emit(AuthFailure(l.message)), 
      (user) => emit(AuthSuccess(user))
    ); 
  }
}
