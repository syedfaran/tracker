import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/user_model.dart';

abstract class DatabaseRepo<T> {
  Future<T> updateUserData();
}

class DatabaseService with DatabaseRepo<void> {
  final String? uid;
  final String? email;
  final String? name;

  DatabaseService({this.email, this.name, this.uid});

  // collection reference
  final  userCollection = FirebaseFirestore.instance.collection('UserNode');

  Future<void> updateUserData() async {
    await userCollection.doc(uid).set({
      'userId': uid,
      'name': name,
      'email': email,
    });
  }

  //setter
  UserData _userDataFromSnapshot(DocumentSnapshot<Map<String,dynamic>> snapshot) {
    return UserData(
        uid: snapshot.data()!['userId'],
        name: snapshot.data()!['name'],
        email: snapshot.data()!['email'],
        );
  }
  //getter
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

}

