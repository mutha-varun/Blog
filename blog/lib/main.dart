import 'package:blog/core/theme/theme.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog/features/auth/domain/usercases/user_signup.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/auth/presentation/pages/signin.dart';
import 'package:blog/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_)=> AuthBloc(
            userSignup: UserSignup(
              AuthRepositoryImpl(
                AuthRemoteDataSourceImpl()
              )
            )
          )
        )
      ],
      child: const Blog(),
    )
  );
}

class Blog extends StatelessWidget {
  const Blog({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkTheme,
      home: const SigninPage()
    ); 
  }
}
