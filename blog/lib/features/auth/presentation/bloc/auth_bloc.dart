import 'dart:math';

import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/core/common/entities/user.dart';
import 'package:blog/features/auth/domain/usercases/current_user.dart';
import 'package:blog/features/auth/domain/usercases/user_signin.dart';
import 'package:blog/features/auth/domain/usercases/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserSignin _userSignin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignup userSignup,
    required UserSignin userSignin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit
  }) : _userSignup = userSignup,
    _userSignin = userSignin,
    _currentUser = currentUser,
    _appUserCubit = appUserCubit,
    super(AuthInitial()) {
    
    on<AuthEvent>((_, emit)=> emit(AuthLoading()));

    on<AuthSignUp>(_onAuthSignUp);

    on<AuthSignIn>(_onAuthSignIn);

    on<AuthIsLoggedIn>(_isLoggedIn);
  }


  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async{
    final res = await _userSignup(UserSignupParameters(
      email: event.email, 
      name: event.name, 
      password: event.password
    ));
    res.fold(
      (l) => emit(AuthFailure(l.message)), 
      (user)=> _emitAuthSuccess(user, emit)
    );
  }


  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async{
   
    final res = await _userSignin(UserSigninParams(email: event.email, 
      password: event.password
    ));

    res.fold(
      (l) => emit(AuthFailure(l.message)), 
      (user) => _emitAuthSuccess(user, emit)
    ); 
  }

  void _isLoggedIn(AuthIsLoggedIn event, Emitter<AuthState> emit) async{

    final res = await _currentUser(NoParams());

    res.fold(
      (l)=> emit(AuthFailure(l.message)), 
      (r)=> _emitAuthSuccess(r, emit)
    
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit){
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
