import 'package:flutter/material.dart';

class NotificationService{
  static late GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar({required  message, Color? color}){
    final snackBar = SnackBar(
      content: Text(message,
                    style: const TextStyle(fontSize: 20,),),
      backgroundColor: color,
      );

      messengerKey.currentState!.showSnackBar(snackBar);
  }
}