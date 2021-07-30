import 'package:flutter/material.dart';
import 'package:flutter_app/businessLogic/SignUp_validation_Provider.dart';
import 'package:flutter_app/businessLogic/loginORregisterbloc.dart';
import 'package:flutter_app/customWidget/textField_container.dart';
import 'package:flutter_app/helper/app_String.dart';
import 'package:flutter_app/helper/toastNotfier.dart';
import 'package:flutter_app/proFirebase/firebaseAuth_provider.dart';
import 'package:provider/provider.dart';

class RegisterState extends StatelessWidget {
  const RegisterState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final signUpFromPro = Provider.of<SignUpFormProvider>(context);
    final authPro = Provider.of<AuthProvider>(context);
    print(authPro.state);
    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.only(
          left: size.width * 0.05,
          right: size.width * 0.05,
          top: size.width * 0.15,
          bottom: size.width * 0.05),
      child: AbsorbPointer(
        absorbing: authPro.state == NotifierState.loading,
        child: ListView(
          children: [
            Text(AppString.registrationScreenSubTitle,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: size.width * 0.1,
                    )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 20),
                TextFieldContainer(hintText: AppString.name,callback: signUpFromPro.setName,errorText: signUpFromPro.getName.error),
                const SizedBox(height: 20),
                TextFieldContainer(hintText: AppString.email,callback: signUpFromPro.setEmail,errorText: signUpFromPro.getEmail.error),
                const SizedBox(height: 20),
                TextFieldContainer(hintText: AppString.password,callback: signUpFromPro.setPassword,errorText: signUpFromPro.getPassword.error,obscureText: true),
                const SizedBox(height: 20),
                TextFieldContainer(hintText: AppString.confirmPassword,callback: signUpFromPro.setConfirmPassword,errorText: signUpFromPro.getConfirmPassword.error,obscureText: true),
                const SizedBox(height: 20),
              ],
            ),
            Column(
              children: [
                ElevatedButton(onPressed: (){
                  context.read<AuthProvider>().createUser(signUpFromPro.getEmail.value!, signUpFromPro.getPassword.value!,signUpFromPro.getName.value!);
                }, child: Text(AppString.signup),
                ),
                if (authPro.state == NotifierState.loading)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: const CircularProgressIndicator(),
                  ),
                if (authPro.state == NotifierState.loaded)
                  authPro.getUserCredential.fold(
                      (failure) {
                        ToastNotifier.showToast(context, failure.message).then((value) {
                          authPro.setState(NotifierState.initial);
                        });
                        return SizedBox();
                      },
                      (success) => const Text(AppString.registerSuccessfully)),
                const SizedBox(height: 30),
                TextButton.icon(
                    onPressed: () {
                      signUpFromPro.submit();
                      context.read<LoginRegisterProvider>().eventToState(LoginEvent.login);
                    },
                    icon: Icon(Icons.arrow_back_ios_outlined),
                    label: Text(
                      'Back To LoginPage',
                      style: Theme.of(context).textTheme.bodyText2,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
