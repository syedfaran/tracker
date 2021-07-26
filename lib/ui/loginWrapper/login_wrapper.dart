import 'package:flutter/material.dart';
import 'package:flutter_app/businessLogic/loginORregisterbloc.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginRegisterProvider(),
      child: Scaffold(
        body: Consumer<LoginRegisterProvider>(
          builder: (_,notifier,__){
            print(notifier.widget);
            return notifier.widget;
          },
        ),
      ),
    );
  }
}
