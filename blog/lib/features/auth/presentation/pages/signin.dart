import 'package:blog/core/theme/pallete.dart';
import 'package:blog/features/auth/presentation/pages/signup.dart';
import 'package:blog/features/auth/presentation/widgets/authbutton.dart';
import 'package:blog/features/auth/presentation/widgets/authfield.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  static route()=> MaterialPageRoute(
      builder: (context)=> const SigninPage()
    );
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
 final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Sign In",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40
                ),
              ),
              const SizedBox(height: 15,),
              Authfield(text: "Email",
                controller: emailController,
              ),
              const SizedBox(height: 20,),
              Authfield(text: "Password",
                controller: passwordController,
                obscure: true,
              ),
              const SizedBox(height: 25,),
              AuthButton(text: "Sign in",
                onTap: () {},
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap:(){
                  Navigator.push(context, 
                    SignupPage.route()
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: "Sign up",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Pallete.gradient2,
                          fontWeight: FontWeight.bold
                        ) 
                      )  
                    ]
                  )
                ),
              )
            ]
          ),
        ),
      )
    );
  }
}