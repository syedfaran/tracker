import 'package:flutter/material.dart';import 'package:flutter_app/businessLogic/loginORregisterbloc.dart';

import 'package:flutter_app/ui/loginWrapper/signIn_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<LoginRegisterBloc>(context);
    return Scaffold(
      body: StreamBuilder<Widget>(
          stream: pro.widgetState,
          initialData: LoginState(),
          builder: (context, snapshot) {
            return snapshot.data!;
          }),
    );
  }
}




