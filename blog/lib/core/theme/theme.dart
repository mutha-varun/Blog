import 'package:blog/core/theme/pallete.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static _border([Color color = Pallete.borderColor] ) =>  OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: 3
    ),
    borderRadius: BorderRadius.circular(15)
  );
    
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(20),
      enabledBorder: _border(),
      focusedBorder: _border(Pallete.gradient2),
      errorBorder: _border(Pallete.errorColor)
    )
  );
}