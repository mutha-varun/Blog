import 'package:blog/core/theme/pallete.dart';
import 'package:blog/features/auth/presentation/widgets/authbutton.dart';
import 'package:blog/features/auth/presentation/widgets/authfield.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
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
              const Text("Sign Up",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40
                ),
              ),
              const SizedBox(height: 15,),
              Authfield(text: "Name",
                controller: nameController,
              ),
              const SizedBox(height: 20,),
              Authfield(text: "Email",
                controller: emailController,
              ),
              const SizedBox(height: 20,),
              Authfield(text: "Password",
                controller: passwordController,
                obscure: true,
              ),
              const SizedBox(height: 25,),
              AuthButton(text: "Sign up",
                onTap: () {},
              ),
              const SizedBox(height: 20,),
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: "Sign in",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Pallete.gradient2,
                        fontWeight: FontWeight.bold
                      ) 
                    )  
                      
                  ]
                )
              )
            ]
          ),
        ),
      )
    );
  }
}