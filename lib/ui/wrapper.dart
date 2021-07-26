import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/homePage.dart';
import 'package:flutter_app/ui/loginWrapper/login_wrapper.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final pro = Provider.of<User>(context);
    //listen for auth Changes display LoginPage or HomePage
    return pro==null?LoginPage():HomePage();
  }
}
