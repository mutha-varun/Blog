import 'package:blog/core/theme/pallete.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const AuthButton({required this.text,required this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Pallete.gradient1,
            Pallete.gradient2,
            Pallete.gradient3
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        ) 
      ),
      child: ElevatedButton(
        onPressed: onTap , 
        style: ElevatedButton.styleFrom(
          backgroundColor: Pallete.transparent,
          shadowColor: Pallete.transparent,
          fixedSize: const Size(390, 55)
        ),
        child: Text(text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600
          ),
        )
      )
    );
  }
}