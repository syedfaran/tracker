import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/loginWrapper/SignInPage.dart';
import 'package:flutter_app/ui/pages/loginWrapper/SignUpPage.dart';


enum LoginEvent { login, register }

class LoginRegisterProvider with ChangeNotifier{
  LoginEvent _event = LoginEvent.login;
  LoginEvent get event=>_event;
  Widget _widget =LoginState();
  Widget get widget=>_widget;
  void eventToState(LoginEvent event){
    switch(event){
      case LoginEvent.login:
        _widget = LoginState();
        break;
      case LoginEvent.register:
        _widget = RegisterState();
        break;
    }
    notifyListeners();
  }
}
