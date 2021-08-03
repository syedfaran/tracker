//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/DataProvider/jobListProvider.dart';
import 'package:flutter_app/myApp.dart';
import 'package:flutter_app/DataProvider/firebaseAuthProvider.dart';
import 'package:provider/provider.dart';

import 'DataProvider/formProvider/SignUpValidationProvider.dart';
import 'DataProvider/formProvider/signInValidationProvider.dart';
import 'DataProvider/formProvider/wrapper_Provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(MultiProvider(providers: [
    StreamProvider<User>.value(
        value: FirebaseAuth.instance.authStateChanges(), initialData: null),
    //StreamProvider<User>(create: (context)=>,initialData: null,),
    ChangeNotifierProvider(create: (context) => SignUpFormProvider()),
    ChangeNotifierProvider(create: (context) => LoginRegisterProvider()),
    Provider(
      create: (context) => SignInFormProvider(),
    ),
    ChangeNotifierProvider(create: (context) => AuthProvider()),
    ChangeNotifierProvider(create: (context) => JobListProvider()),
  ], child: MyApp()));
}
