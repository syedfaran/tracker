import 'package:flutter/material.dart';
import 'package:flutter_app/theme/app_color.dart';

ThemeData themeOne = ThemeData(

    brightness: Brightness.light,
    backgroundColor: AppColor.bodyColor,
    scaffoldBackgroundColor: AppColor.bodyColor,
    hintColor: AppColor.textColor,
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



