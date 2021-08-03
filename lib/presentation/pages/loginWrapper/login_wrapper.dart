import 'package:flutter/material.dart';
import 'package:flutter_app/DataProvider/form_provider/wrapper_Provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginRegisterProvider>(
        builder: (_,notifier,__){
          return notifier.widget;
        },
      ),
    );
  }
}
