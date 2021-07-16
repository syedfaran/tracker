import 'dart:async';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

class ToastNotifier{

  static showBlockDialog(BuildContext context, Completer completer){
    context.showBlockDialog(dismissCompleter: completer);
  }

  static Future<void> showToast(BuildContext context, String message) async{
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showFlash(context: context,duration: Duration(seconds: 3),builder: (context, controller){
        return Flash.dialog(
          controller: controller,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          backgroundGradient: LinearGradient(
            colors: [Colors.indigo, Colors.deepPurple],
          ),
          // Alignment is only available for the "dialog" named constructor
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.only(bottom: 48),
          // Child can be any widget you like, this one just displays a padded text
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        );
      });
      // Add Your Code here.
    });
  }
}