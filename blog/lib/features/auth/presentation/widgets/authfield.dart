import 'package:flutter/material.dart';

class Authfield extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final bool obscure;
  const Authfield({required this.controller ,required this.text,this.obscure = false,super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      controller: controller,
      decoration: InputDecoration(
        hintText: text
      ),
      validator: (value) {
        if(value!.isEmpty){
          return "$text is missing";
        }

        return null;
      },
    );
  }
}