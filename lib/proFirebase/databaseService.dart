import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/data/model/user_model.dart';


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
  //when user SignUp for the first Time i.e setter
  Future<void> updateUserData() async {
    await userCollection.doc(uid).set({
      'userId': uid,
      'name': name,
      'email': email,
    });
  }

  //mapping json to userData Obj.
  UserData _userDataFromSnapshot(DocumentSnapshot<Map<String,dynamic>> snapshot) {
    return UserData.fromJson(snapshot.data()!);

  }
  //getter
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

}

