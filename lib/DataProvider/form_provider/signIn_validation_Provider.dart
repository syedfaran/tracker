

import 'SignUp_validation_Provider.dart';

class SignInFormProvider {
  Validator _email = Validator(null, null);
  Validator _password = Validator(null, null);
  Validator get getEmail => _email;
  Validator get getPassword => _password;

  void setEmail(String email) {
    if (email.isNotEmpty) {
      _email = Validator(email.trim(), null);
    }
  }

  void setPassword(String password) {
    if (password.isNotEmpty) {
      _password = Validator(password.trim(), null);
    }
  }

  void submit() {
    print(_email.value);
    print(_password.value);
  }

}
