import 'package:blog/core/theme/theme.dart';
import 'package:blog/features/auth/presentation/pages/signin.dart';

import 'package:flutter/material.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkTheme,
      home: const SigninPage()
    ); 
  }
}
