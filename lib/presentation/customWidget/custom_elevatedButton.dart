import 'package:flutter/material.dart';

class RElevatedButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  const RElevatedButton({Key? key, required this.onPressed, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed,child: Text(text),);
  }
}
