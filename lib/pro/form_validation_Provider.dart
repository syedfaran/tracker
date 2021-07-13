
import 'package:flutter/material.dart';

//todo generic Class pending

class Validator{
  final String? value;
  final String? error;
  const Validator(this.value,this.error);
}


class FormProvider with ChangeNotifier {
  Validator _email = Validator(null, null);
  Validator _password = Validator(null, null);
  Validator _name = Validator(null, null);
  Validator _confirmPassword = Validator(null, null);
  Validator get getEmail=>_email;
  Validator get getPassword=>_password;
  Validator get getName=>_name;
  Validator get getConfirmPassword=>_confirmPassword;
  void setEmail(String email){
    if(email.contains('@')){
      _email = Validator(email, null);
    }else{
      _email = Validator(null, 'Invalid Email Format');
    }
    notifyListeners();
  }

  void setPassword(String password){
    if(password.length>6){
      _password = Validator(password, null);
    }else{
      _password = Validator(null,'Password must be at least 6 character');
    }
    notifyListeners();
  }

  void setName(String name){
    if(name.length>3){
      _name = Validator(name, null);
    }else{
      _name = Validator(null,'Password must be at least 3 character');
    }
    notifyListeners();
  }

  void setConfirmPassword(String confirmPassword){
    if(_password.value ==confirmPassword){
      _confirmPassword = Validator(confirmPassword, null);
    }else{
      _confirmPassword = Validator(null,'Password not match');
    }
    notifyListeners();
  }

  void submit(){
    print(_email.value);
    print(_password.value);
    print(_confirmPassword.value);
    print(_name.value);
  }

}
