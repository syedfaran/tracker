import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final String? hintText;
  final void Function(String)? callback;
  final String? errorText;
  final bool? obscureText;

  const TextFieldContainer(
      {Key? key,
      this.hintText,
      this.callback,
      this.errorText,
      this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: TextField(
        onChanged: callback,
        obscureText: obscureText==null?false:true,
        decoration: InputDecoration(
            errorText: errorText, border: InputBorder.none, hintText: hintText),
      ),
    );
  }
}
