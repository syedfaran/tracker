class UserData {

   String? uid;
   String? name;
   String? email;

   UserData({ this.uid, this.email,this.name });


  UserData.fromJson(Map<String, dynamic> json) {
    uid = json['userId'];
    name = json['name'];
    email = json['email'];
  }



}