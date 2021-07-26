//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/DataProvider/joblistProvider.dart';
import 'package:flutter_app/businessLogic/SignUp_validation_Provider.dart';
import 'package:flutter_app/myApp.dart';
import 'package:flutter_app/proFirebase/firebaseAuth_provider.dart';
import 'package:flutter_app/ui/g_map/map_page.dart';
import 'package:provider/provider.dart';


void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(MultiProvider(providers: [
    StreamProvider<User>(create: (context)=>FirebaseAuth.instance.authStateChanges(),initialData: null,),
    ChangeNotifierProvider(create: (context) => FormProvider()),
    ChangeNotifierProvider(create: (context)=>AuthProvider()),
    ChangeNotifierProvider(create: (context)=>JobListProvider()),
  ], child: MyApp()));
}
