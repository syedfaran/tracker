import 'package:flutter/material.dart';

class RETextButtonIcon extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final IconData? iconData;

  const RETextButtonIcon(
      {Key? key, required this.onPressed, required this.text, this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: onPressed,
        icon: Icon(iconData, color: Theme.of(context).iconTheme.color),
        label: Text(text,style: Theme.of(context).textTheme.bodyText2));
  }
}
