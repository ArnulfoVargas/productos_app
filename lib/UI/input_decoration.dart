import 'package:flutter/material.dart';

class FormInputDecorator{

  static InputDecoration getInputDecoration
    ({
      IconData? icon, 
      required String hintText, 
      required String labelText
    }) 
  {
    return InputDecoration(
            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple)),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
            hintText: hintText,
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.deepPurple),
            prefixIcon: icon == null ? null : Icon(icon, color: Colors.deepPurple,)
          );
  }
}