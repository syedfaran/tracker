import 'package:flutter/material.dart';
import 'package:flutter_app/businessLogic/loginORregisterbloc.dart';
import 'package:flutter_app/businessLogic/signIn_validation.dart';
import 'package:flutter_app/customWidget/custom_loader.dart';
import 'package:flutter_app/customWidget/textField_container.dart';
import 'package:flutter_app/helper/app_String.dart';
import 'package:flutter_app/helper/toastNotfier.dart';
import 'package:flutter_app/proFirebase/firebaseAuth_provider.dart';
import 'package:provider/provider.dart';

class LoginState extends StatelessWidget {
  const LoginState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    final authPro = Provider.of<AuthProvider>(context);
    final signInFormPro = Provider.of<SignInFormProvider>(context);
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
            Text(AppString.welcomeScreenTitle,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: size.width * 0.1,
                    )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 20),
                TextFieldContainer(hintText: AppString.email, callback: signInFormPro.setEmail),
                const SizedBox(height: 20),
                TextFieldContainer(hintText: AppString.password, callback: signInFormPro.setPassword, obscureText: true),
                const SizedBox(height: 20),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed:() {
                    signInFormPro.submit();
                    context.read<AuthProvider>().signInUser(
                        signInFormPro.getEmail.value!, signInFormPro.getPassword.value!);
                  },
                  child: Text(AppString.signIn),
                ),
                if (authPro.state == NotifierState.loading)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: const CustomLoader(),
                  ),
                if (authPro.state == NotifierState.loaded)
                  authPro.getUserCredential.fold((failure) {
                    ToastNotifier.showToast(context, failure.message)
                        .then((value) {
                      authPro.setState(NotifierState.initial);
                    });
                    return const SizedBox();
                  }, (success) {
                    // ToastNotifier.showToast(context, AppString.signedInSuccessfully).then((value){});
                    return const SizedBox();
                  }),
                SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    context
                        .read<LoginRegisterProvider>()
                        .eventToState(LoginEvent.register);
                  },
                  child: Text(AppString.signup,
                      style: Theme.of(context).textTheme.bodyText2),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
