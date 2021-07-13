import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/proFirebase/firebaseAuth_Repo.dart';

enum NotifierState { initial, loading, loaded }

class AuthProvider with ChangeNotifier {
  NotifierState _state = NotifierState.initial;

  NotifierState get state => _state;
  Either<Failure, UserCredential>? _credential;

  Either<Failure, UserCredential> get getUserCredential => _credential!;
  Failure? _failure;

  Failure get failure => _failure!;

  Future<void> createUser(String email, String password) async {
    print(email);
    print(password);
    _setState(NotifierState.loading);
    await Task(() => EmailUser(email: email, password: password).register())
        .attempt()
        .map(
      // Grab only the *left* side of Either<Object, Post>
          (either) => either.leftMap((obj) {
        try {
          // Cast the Object into a Failure
          return obj as Failure;
        } catch (e) {
          // 'rethrow' the original exception
          throw obj;
        }
      }),
    )
        .run()
        .then((value) => _setUser(value));
    _setState(NotifierState.loaded);
  }

  Future<void> signInUser(String email, String password) async {
    _setState(NotifierState.loading);
    await EmailUser(email: email, password: password)
        .signIn()
        .then((value) => null);
    _setState(NotifierState.loaded);
  }

  //*************setState*****************************
  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  void _setFailure(Failure failure) {
    _failure = failure;
    notifyListeners();
  }

  void _setUser(Either<Failure, UserCredential> credential) {
    _credential = credential;

    notifyListeners();
  }
}
