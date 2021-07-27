import 'package:flutter/material.dart';

class RElevatedButton extends StatelessWidget {
  final void Function()? callback;
  final Widget? child;
  const RElevatedButton({Key? key, this.callback, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: callback, child: child);
  }
}
