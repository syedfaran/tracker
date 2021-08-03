import 'package:flutter/material.dart';
import 'package:flutter_app/ui/theme/appColor.dart';

ThemeData themeOne = ThemeData(
    brightness: Brightness.light,
    backgroundColor: AppColor.scaffoldColor,
    scaffoldBackgroundColor: AppColor.scaffoldColor,
    hintColor: AppColor.textFieldHintColor,
    primaryColorLight: AppColor.buttonBackgroundColor,
    textTheme: TextTheme(
        headline1: TextStyle(
            color: AppColor.bluePrimaryColor,
            fontSize: 40,
            fontWeight: FontWeight.bold
        ),
        bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 16,
        ),
        bodyText2: TextStyle(
            color: Colors.black,
            fontSize: 16,
        ),
    ),
    iconTheme: IconThemeData(
        color: AppColor.bluePrimaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(AppColor.bluePrimaryColor,),
        )
    )
);


