// @dart=2.9

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/businessLogic/form_validation_Provider.dart';
import 'package:flutter_app/businessLogic/loginORregisterbloc.dart';
import 'package:flutter_app/myApp.dart';

import 'package:flutter_app/proFirebase/firebaseAuth_provider.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(MultiProvider(providers: [
    StreamProvider(create: (context)=>FirebaseAuth.instance.authStateChanges(),),
    Provider(create: (context) => LoginRegisterBloc()),
    ChangeNotifierProvider(create: (context) => FormProvider()),
    ChangeNotifierProvider(create: (context)=>AuthProvider()),
  ], child: MyApp()));
}
