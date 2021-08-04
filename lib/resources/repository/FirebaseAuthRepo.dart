import 'package:flutter_app/DataProvider/DatabaseProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Failure{
  final String message;
  Failure(this.message);

}

abstract class UserRepository<T> {
  Future<T> register();

  Future<T> signIn();

  Future<void> signOut();
}

class EmailUser implements UserRepository<UserCredential> {
  final String? email;
  final String? password;
  final String? name;
  EmailUser({this.email, this.password,this.name});

  @override
  Future<UserCredential> register() async {
    try{
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!);
      await DatabaseService(email: email,name: name,uid: userCredential.user!.uid.toString()).updateUserData();
      return userCredential;
    }on FirebaseAuthException catch(e) {
      if(e.code == 'weak-password'){
        throw Failure('The password provided is too weak');
      }else if (e.code == 'email-already-in-use'){
        throw Failure('The account already exists for that email');
      }else{
        throw Failure(e.code);
      }
    }
  }

  @override
  Future<UserCredential> signIn() async {
    try{
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      return userCredential;
    }on FirebaseAuthException catch(e) {
      if(e.code == 'user-not-found'){
        throw Failure('No user found for that email.');
      }else if (e.code == 'wrong-password'){
        throw Failure('Wrong password provided for that user.');
      }else{
        throw Failure(e.code);
      }
    }
  }
  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }


}


