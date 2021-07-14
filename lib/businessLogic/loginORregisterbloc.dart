import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/loginWrapper/signIn_page.dart';
import 'package:flutter_app/ui/loginWrapper/signUp_page.dart';
import 'package:rxdart/rxdart.dart';

enum LoginEvent { login, register }

class LoginRegisterBloc {
  final _event = BehaviorSubject<LoginEvent>.seeded(LoginEvent.login);
  final _state = BehaviorSubject<Widget>();

  StreamSink<LoginEvent> get changeState => _event.sink;

  Stream<Widget> get widgetState => _state.stream;

  LoginRegisterBloc() {
    _event.listen((value) {
      switch (value) {
        case LoginEvent.login:
          _state.sink.add(LoginState());
          break;
        case LoginEvent.register:
          _state.sink.add(RegisterState());
          break;
      }
    });
  }

  void dispose() {
    _state.close();
    _event.close();
  }
}
